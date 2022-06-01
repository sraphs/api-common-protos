package timestamppb

import (
	"database/sql"
	"database/sql/driver"
	"time"

	"google.golang.org/protobuf/encoding/protojson"
)

func (date *Timestamp) Scan(value interface{}) (err error) {
	nullTime := &sql.NullTime{}
	err = nullTime.Scan(value)
	*date = Timestamp{
		Seconds: int64(nullTime.Time.Second()),
		Nanos:   int32(nullTime.Time.Nanosecond()),
	}
	return err
}

func (date *Timestamp) Value() (driver.Value, error) {
	y, m, d := time.Time(date.AsTime()).Date()
	return time.Date(y, m, d, 0, 0, 0, 0, time.Time(date.AsTime()).Location()), nil
}

// GormDataType gorm common data type
func (date *Timestamp) GormDataType() string {
	return "date"
}

func (date *Timestamp) GobEncode() ([]byte, error) {
	return time.Time(date.AsTime()).GobEncode()
}

func (date *Timestamp) GobDecode(b []byte) error {
	t := date.AsTime()
	err := (*time.Time)(&t).GobDecode(b)
	*date = *New(t)
	return err
}

func (date *Timestamp) MarshalJSON() ([]byte, error) {
	return protojson.Marshal(date)
}

func (date *Timestamp) UnmarshalJSON(b []byte) error {
	return protojson.Unmarshal(b, date)
}
