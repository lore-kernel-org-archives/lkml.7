Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4850BC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 22:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1326C2087B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 22:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfHKW4L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 18:56:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfHKW4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 18:56:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7BMpWFC011334
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 18:56:10 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uab1a19gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 18:56:09 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-kernel@vger.kernel.org> from <miltonm@us.ibm.com>;
        Sun, 11 Aug 2019 22:56:09 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Sun, 11 Aug 2019 22:55:58 -0000
Received: from us1a3-mail228.a3.dal06.isc4sb.com ([10.146.103.71])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2019081122555865-484507 ;
          Sun, 11 Aug 2019 22:55:58 +0000 
In-Reply-To: <20190810095406.5509-1-wangzqbj@inspur.com>
From:   "Milton Miller II" <miltonm@us.ibm.com>
To:     John Wang <wangzqbj@inspur.com>
Cc:     <jdelvare@suse.com>, <linux@roeck-us.net>, <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <duanzhijia01@inspur.com>, <mine260309@gmail.com>
Date:   Sun, 11 Aug 2019 22:55:57 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190810095406.5509-1-wangzqbj@inspur.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 21851
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19081122-2475-0000-0000-0000004A6100
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.150957
X-IBM-SpamModules-Versions: BY=3.00011583; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01245464; UDB=6.00657172; IPR=6.01026961;
 MB=3.00028138; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-11 22:56:06
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-11 22:01:25 - 6.00010274
x-cbparentid: 19081122-2476-0000-0000-00000071745F
Message-Id: <OFD41F14A3.C9368CBA-ON00258453.007B620B-00258453.007DF926@notes.na.collabserv.com>
Subject: Re:  [PATCH v2 2/2] hwmon: pmbus: Add Inspur Power System power supply
 driver
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-11_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Around 08/10/2019 04:55AM in some time zone, John Wang wrote:
>
>Add the driver to monitor Inspur Power System power supplies
>with hwmon over pmbus.
>
>This driver adds sysfs attributes for additional power supply data,
>including vendor, model, part_number, serial number,
>firmware revision, hardware revision, and psu mode(active/standby).
>
>Signed-off-by: John Wang <wangzqbj@inspur.com>
>---
>v2:
>    - Fix typos in commit message
>    - Invert Christmas tree
>    - Configure device with sysfs attrs, not debugfs entries
>    - Fix errno in fw_version_read, ENODATA to EPROTO
>    - Change the print format of fw-version
>    - Use sysfs_streq instead of strcmp("xxx" "\n", "xxx")
>    - Document sysfs attributes
>---
> Documentation/hwmon/inspur-ipsps1.rst |  79 +++++++++
> drivers/hwmon/pmbus/Kconfig           |   9 +
> drivers/hwmon/pmbus/Makefile          |   1 +
> drivers/hwmon/pmbus/inspur-ipsps.c    | 236
>++++++++++++++++++++++++++
> 4 files changed, 325 insertions(+)
> create mode 100644 Documentation/hwmon/inspur-ipsps1.rst
> create mode 100644 drivers/hwmon/pmbus/inspur-ipsps.c
>
>diff --git a/Documentation/hwmon/inspur-ipsps1.rst
>b/Documentation/hwmon/inspur-ipsps1.rst
....
>diff --git a/drivers/hwmon/pmbus/Kconfig>b/drivers/hwmon/pmbus/Kconfig
>index 30751eb9550a..c09357c26b10 100644
>--- a/drivers/hwmon/pmbus/Kconfig
>+++ b/drivers/hwmon/pmbus/Kconfig
>@@ -203,4 +203,13 @@ config SENSORS_ZL6100
> 	  This driver can also be built as a module. If so, the module will
> 	  be called zl6100.
> 
>+config SENSORS_INSPUR_IPSPS
>+	tristate "INSPUR Power System Power Supply"

The entries in this file are sorted alphabetically.

>diff --git a/drivers/hwmon/pmbus/Makefile>b/drivers/hwmon/pmbus/Makefile
>index 2219b9300316..fde2d10cd05c 100644
>--- a/drivers/hwmon/pmbus/Makefile
>+++ b/drivers/hwmon/pmbus/Makefile
>@@ -23,3 +23,4 @@ obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
> obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
> obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
> obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
>+obj-$(CONFIG_SENSORS_INSPUR_IPSPS)	+= inspur-ipsps.o
>diff --git a/drivers/hwmon/pmbus/inspur-ipsps.c
>b/drivers/hwmon/pmbus/inspur-ipsps.c
>new file mode 100644
>index 000000000000..f6dd10a62aef
>--- /dev/null
>+++ b/drivers/hwmon/pmbus/inspur-ipsps.c
>@@ -0,0 +1,236 @@
>+// SPDX-License-Identifier: GPL-2.0-or-later
>+/*
>+ * Copyright 2019 Inspur Corp.
>+ */
>+
>+#include <linux/debugfs.h>
>+#include <linux/device.h>
>+#include <linux/fs.h>
>+#include <linux/i2c.h>
>+#include <linux/module.h>
>+#include <linux/pmbus.h>
>+#include <linux/hwmon-sysfs.h>
>+
>+#include "pmbus.h"
>+
>+#define IPSPS_REG_VENDOR_ID	0x99
>+#define IPSPS_REG_MODEL		0x9A
>+#define IPSPS_REG_FW_VERSION	0x9B
>+#define IPSPS_REG_PN		0x9C
>+#define IPSPS_REG_SN		0x9E
>+#define IPSPS_REG_HW_VERSION	0xB0
>+#define IPSPS_REG_MODE		0xFC
>+
>+#define MODE_ACTIVE		0x55
>+#define MODE_STANDBY		0x0E
>+#define MODE_REDUNDANCY		0x00
>+
>+#define MODE_ACTIVE_STRING		"active"
>+#define MODE_STANDBY_STRING		"standby"
>+#define MODE_REDUNDANCY_STRING		"redundancy"
>+
>+enum ipsps_index {
>+	vendor,
>+	model,
>+	fw_version,
>+	part_number,
>+	serial_number,
>+	hw_version,
>+	mode,
>+	num_regs,
>+};
>+
>+static const u8 ipsps_regs[num_regs] = {
>+	[vendor] = IPSPS_REG_VENDOR_ID,
>+	[model] = IPSPS_REG_MODEL,
>+	[fw_version] = IPSPS_REG_FW_VERSION,
>+	[part_number] = IPSPS_REG_PN,
>+	[serial_number] = IPSPS_REG_SN,
>+	[hw_version] = IPSPS_REG_HW_VERSION,
>+	[mode] = IPSPS_REG_MODE,
>+};
>+
>+static ssize_t ipsps_string_show(struct device *dev,
>+				 struct device_attribute *devattr,
>+				 char *buf)
>+{
>+	u8 reg;
>+	int rc, i;
>+	char data[I2C_SMBUS_BLOCK_MAX + 1] = { 0 };

Shouldn't need to initialize this.

>+	struct i2c_client *client = to_i2c_client(dev->parent);>+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>+
>+	reg = ipsps_regs[attr->index];
>+	rc = i2c_smbus_read_block_data(client, reg, data);
>+	if (rc < 0)
>+		return rc;
>+
>+	for (i = 0; i < rc; i++) {
>+		/* filled with printable characters, ending with # */
>+		if (data[i] == '#')
>+			break;
>+	}

This seems to be p = memscan(data, '#', rc);

>+>+	data[i] = '\0';
>+
>+	return snprintf(buf, PAGE_SIZE, "%s\n", data);
>+}
>+
>+static ssize_t ipsps_fw_version_show(struct device *dev,
>+				     struct device_attribute *devattr,
>+				     char *buf)
>+{
>+	u8 reg;
>+	int rc;
>+	u8 data[I2C_SMBUS_BLOCK_MAX] = { 0 };
>+	struct i2c_client *client = to_i2c_client(dev->parent);
>+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>+
>+	reg = ipsps_regs[attr->index];
>+	rc = i2c_smbus_read_block_data(client, reg, data);
>+	if (rc < 0)
>+		return rc;
>+
>+	if (rc != 6)
>+		return -EPROTO;
>+
>+	return snprintf(buf, PAGE_SIZE, "%u.%02u%u-%u.%02u\n",
>+			data[1], data[2]/* < 100 */, data[3]/*< 10*/,
>+			data[4], data[5]/* < 100 */);
>+}
>+
>+static ssize_t ipsps_mode_show(struct device *dev,
>+			       struct device_attribute *devattr, char *buf)
>+{
>+	u8 reg;
>+	int rc;
>+	struct i2c_client *client = to_i2c_client(dev->parent);
>+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>+
>+	reg = ipsps_regs[attr->index];
>+	rc = i2c_smbus_read_byte_data(client, reg);
>+	if (rc < 0)
>+		return rc;
>+
>+	switch (rc) {
>+	case MODE_ACTIVE:
>+		return snprintf(buf, PAGE_SIZE, "[%s] %s %s\n",
>+				MODE_ACTIVE_STRING,
>+				MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
>+	case MODE_STANDBY:
>+		return snprintf(buf, PAGE_SIZE, "%s [%s] %s\n",
>+				MODE_ACTIVE_STRING,
>+				MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
>+	case MODE_REDUNDANCY:
>+		return snprintf(buf, PAGE_SIZE, "%s %s [%s]\n",
>+				MODE_ACTIVE_STRING,
>+				MODE_STANDBY_STRING, MODE_REDUNDANCY_STRING);
>+	default:
>+		return snprintf(buf, PAGE_SIZE, "unspecified\n");
>+	}
>+}
>+
>+static ssize_t ipsps_mode_store(struct device *dev,
>+				struct device_attribute *devattr,
>+				const char *buf, size_t count)
>+{
>+	u8 reg;
>+	int rc;
>+	struct i2c_client *client = to_i2c_client(dev->parent);
>+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>+
>+	reg = ipsps_regs[attr->index];
>+	if (sysfs_streq(MODE_STANDBY_STRING, buf)) {
>+		rc = i2c_smbus_write_byte_data(client, reg,
>+					       MODE_STANDBY);
>+		if (rc < 0)
>+			return rc;
>+		return count;
>+	} else if (sysfs_streq(MODE_ACTIVE_STRING, buf)) {
>+		rc = i2c_smbus_write_byte_data(client, reg,
>+					       MODE_ACTIVE);
>+		if (rc < 0)
>+			return rc;
>+		return count;
>+	}
>+
>+	return -EINVAL;
>+}
>+
>+static SENSOR_DEVICE_ATTR_RO(vendor, ipsps_string, vendor);
>+static SENSOR_DEVICE_ATTR_RO(model, ipsps_string, model);
>+static SENSOR_DEVICE_ATTR_RO(part_number, ipsps_string,
>part_number);
>+static SENSOR_DEVICE_ATTR_RO(serial_number, ipsps_string,
>serial_number);
>+static SENSOR_DEVICE_ATTR_RO(hw_version, ipsps_string, hw_version);
>+static SENSOR_DEVICE_ATTR_RO(fw_version, ipsps_fw_version,
>fw_version);
>+static SENSOR_DEVICE_ATTR_RW(mode, ipsps_mode, mode);
>+
>+static struct attribute *enable_attrs[] = {
>+	&sensor_dev_attr_vendor.dev_attr.attr,
>+	&sensor_dev_attr_model.dev_attr.attr,
>+	&sensor_dev_attr_part_number.dev_attr.attr,
>+	&sensor_dev_attr_serial_number.dev_attr.attr,
>+	&sensor_dev_attr_hw_version.dev_attr.attr,
>+	&sensor_dev_attr_fw_version.dev_attr.attr,
>+	&sensor_dev_attr_mode.dev_attr.attr,
>+	NULL,
>+};
>+
>+static const struct attribute_group enable_group = {
>+	.attrs = enable_attrs,
>+};
>+
>+static const struct attribute_group *attribute_groups[] = {
>+	&enable_group,
>+	NULL,
>+};

ATTRIBUTE_GROUPS(enable);

>+
>+static struct pmbus_driver_info ipsps_info = {
>+	.pages = 1,
>+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
>+		PMBUS_HAVE_IIN | PMBUS_HAVE_POUT | PMBUS_HAVE_PIN |
>+		PMBUS_HAVE_FAN12 | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
>+		PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_VOUT |
>+		PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT |
>+		PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_STATUS_FAN12,
>+	.groups = attribute_groups,
>+};
>+
>+static struct pmbus_platform_data ipsps_pdata = {
>+	.flags = PMBUS_SKIP_STATUS_CHECK,
>+};
>+
>+static int ipsps_probe(struct i2c_client *client,
>+		       const struct i2c_device_id *id)
>+{
>+	client->dev.platform_data = &ipsps_pdata;
>+	return pmbus_do_probe(client, id, &ipsps_info);
>+}
>+
>+static const struct i2c_device_id ipsps_id[] = {
>+	{ "inspur_ipsps1", 0 },
>+	{}
>+};
>+MODULE_DEVICE_TABLE(i2c, ipsps_id);
>+
>+static const struct of_device_id ipsps_of_match[] = {
>+	{ .compatible = "inspur,ipsps1" },
>+	{}
>+};
>+MODULE_DEVICE_TABLE(of, ipsps_of_match);
>+
>+static struct i2c_driver ipsps_driver = {
>+	.driver = {
>+		.name = "inspur-ipsps",
>+		.of_match_table = ipsps_of_match,
>+	},
>+	.probe = ipsps_probe,
>+	.remove = pmbus_do_remove,
>+	.id_table = ipsps_id,
>+};
>+
>+module_i2c_driver(ipsps_driver);
>+
>+MODULE_AUTHOR("John Wang");
>+MODULE_DESCRIPTION("PMBus driver for Inspur Power System power
>supplies");
>+MODULE_LICENSE("GPL");
>-- 
>2.17.1
>
>

