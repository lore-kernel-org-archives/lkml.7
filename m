Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08638C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D358A207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgAFPdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:33:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726437AbgAFPdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:33:07 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006FN0bD025474;
        Mon, 6 Jan 2020 10:32:45 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xb8wwxtf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jan 2020 10:32:44 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 006FPuWc033266;
        Mon, 6 Jan 2020 10:32:44 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xb8wwxtex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jan 2020 10:32:44 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 006FUxQ5022027;
        Mon, 6 Jan 2020 15:32:50 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01wdc.us.ibm.com with ESMTP id 2xajb635m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jan 2020 15:32:49 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 006FWgwn46399814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jan 2020 15:32:43 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2B89BE051;
        Mon,  6 Jan 2020 15:32:42 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E249BE04F;
        Mon,  6 Jan 2020 15:32:42 +0000 (GMT)
Received: from [9.163.15.26] (unknown [9.163.15.26])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jan 2020 15:32:42 +0000 (GMT)
Subject: Re: [PATCH 1/3] hwmon: (pmbus/ibm-cffps) Add new manufacturer debugfs
 entries
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, bjwyman@gmail.com
References: <1576788607-13567-1-git-send-email-eajames@linux.ibm.com>
 <1576788607-13567-2-git-send-email-eajames@linux.ibm.com>
 <20200104162608.GA8155@roeck-us.net>
From:   Eddie James <eajames@linux.ibm.com>
Message-ID: <26c91d06-0e6f-84e9-87f5-6df5778176ba@linux.ibm.com>
Date:   Mon, 6 Jan 2020 09:32:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200104162608.GA8155@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_04:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/4/20 10:26 AM, Guenter Roeck wrote:
> On Thu, Dec 19, 2019 at 02:50:05PM -0600, Eddie James wrote:
>> Add support for a number of manufacturer-specific registers in the
>> debugfs entries, as well as support to read and write the
>> PMBUS_ON_OFF_CONFIG register through debugfs.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> I assume you know what you are doing, letting the user write anything
> into on_off_config. Applied to -next.


Thanks for merging the series! Yep, that's the requirement I was given...


Cheers,

Eddie


>
> Guenter
>
>> ---
>>   drivers/hwmon/pmbus/ibm-cffps.c | 74 ++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 70 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
>> index d359b76..a564be9 100644
>> --- a/drivers/hwmon/pmbus/ibm-cffps.c
>> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
>> @@ -20,7 +20,9 @@
>>   
>>   #define CFFPS_FRU_CMD				0x9A
>>   #define CFFPS_PN_CMD				0x9B
>> +#define CFFPS_HEADER_CMD			0x9C
>>   #define CFFPS_SN_CMD				0x9E
>> +#define CFFPS_MAX_POWER_OUT_CMD			0xA7
>>   #define CFFPS_CCIN_CMD				0xBD
>>   #define CFFPS_FW_CMD				0xFA
>>   #define CFFPS1_FW_NUM_BYTES			4
>> @@ -57,9 +59,12 @@ enum {
>>   	CFFPS_DEBUGFS_INPUT_HISTORY = 0,
>>   	CFFPS_DEBUGFS_FRU,
>>   	CFFPS_DEBUGFS_PN,
>> +	CFFPS_DEBUGFS_HEADER,
>>   	CFFPS_DEBUGFS_SN,
>> +	CFFPS_DEBUGFS_MAX_POWER_OUT,
>>   	CFFPS_DEBUGFS_CCIN,
>>   	CFFPS_DEBUGFS_FW,
>> +	CFFPS_DEBUGFS_ON_OFF_CONFIG,
>>   	CFFPS_DEBUGFS_NUM_ENTRIES
>>   };
>>   
>> @@ -136,15 +141,15 @@ static ssize_t ibm_cffps_read_input_history(struct ibm_cffps *psu,
>>   				       psu->input_history.byte_count);
>>   }
>>   
>> -static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
>> -				    size_t count, loff_t *ppos)
>> +static ssize_t ibm_cffps_debugfs_read(struct file *file, char __user *buf,
>> +				      size_t count, loff_t *ppos)
>>   {
>>   	u8 cmd;
>>   	int i, rc;
>>   	int *idxp = file->private_data;
>>   	int idx = *idxp;
>>   	struct ibm_cffps *psu = to_psu(idxp, idx);
>> -	char data[I2C_SMBUS_BLOCK_MAX] = { 0 };
>> +	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
>>   
>>   	pmbus_set_page(psu->client, 0);
>>   
>> @@ -157,9 +162,20 @@ static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
>>   	case CFFPS_DEBUGFS_PN:
>>   		cmd = CFFPS_PN_CMD;
>>   		break;
>> +	case CFFPS_DEBUGFS_HEADER:
>> +		cmd = CFFPS_HEADER_CMD;
>> +		break;
>>   	case CFFPS_DEBUGFS_SN:
>>   		cmd = CFFPS_SN_CMD;
>>   		break;
>> +	case CFFPS_DEBUGFS_MAX_POWER_OUT:
>> +		rc = i2c_smbus_read_word_swapped(psu->client,
>> +						 CFFPS_MAX_POWER_OUT_CMD);
>> +		if (rc < 0)
>> +			return rc;
>> +
>> +		rc = snprintf(data, I2C_SMBUS_BLOCK_MAX, "%d", rc);
>> +		goto done;
>>   	case CFFPS_DEBUGFS_CCIN:
>>   		rc = i2c_smbus_read_word_swapped(psu->client, CFFPS_CCIN_CMD);
>>   		if (rc < 0)
>> @@ -199,6 +215,14 @@ static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
>>   			return -EOPNOTSUPP;
>>   		}
>>   		goto done;
>> +	case CFFPS_DEBUGFS_ON_OFF_CONFIG:
>> +		rc = i2c_smbus_read_byte_data(psu->client,
>> +					      PMBUS_ON_OFF_CONFIG);
>> +		if (rc < 0)
>> +			return rc;
>> +
>> +		rc = snprintf(data, 3, "%02x", rc);
>> +		goto done;
>>   	default:
>>   		return -EINVAL;
>>   	}
>> @@ -214,9 +238,42 @@ static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
>>   	return simple_read_from_buffer(buf, count, ppos, data, rc);
>>   }
>>   
>> +static ssize_t ibm_cffps_debugfs_write(struct file *file,
>> +				       const char __user *buf, size_t count,
>> +				       loff_t *ppos)
>> +{
>> +	u8 data;
>> +	ssize_t rc;
>> +	int *idxp = file->private_data;
>> +	int idx = *idxp;
>> +	struct ibm_cffps *psu = to_psu(idxp, idx);
>> +
>> +	switch (idx) {
>> +	case CFFPS_DEBUGFS_ON_OFF_CONFIG:
>> +		pmbus_set_page(psu->client, 0);
>> +
>> +		rc = simple_write_to_buffer(&data, 1, ppos, buf, count);
>> +		if (rc < 0)
>> +			return rc;
>> +
>> +		rc = i2c_smbus_write_byte_data(psu->client,
>> +					       PMBUS_ON_OFF_CONFIG, data);
>> +		if (rc)
>> +			return rc;
>> +
>> +		rc = 1;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>>   static const struct file_operations ibm_cffps_fops = {
>>   	.llseek = noop_llseek,
>> -	.read = ibm_cffps_debugfs_op,
>> +	.read = ibm_cffps_debugfs_read,
>> +	.write = ibm_cffps_debugfs_write,
>>   	.open = simple_open,
>>   };
>>   
>> @@ -486,15 +543,24 @@ static int ibm_cffps_probe(struct i2c_client *client,
>>   	debugfs_create_file("part_number", 0444, ibm_cffps_dir,
>>   			    &psu->debugfs_entries[CFFPS_DEBUGFS_PN],
>>   			    &ibm_cffps_fops);
>> +	debugfs_create_file("header", 0444, ibm_cffps_dir,
>> +			    &psu->debugfs_entries[CFFPS_DEBUGFS_HEADER],
>> +			    &ibm_cffps_fops);
>>   	debugfs_create_file("serial_number", 0444, ibm_cffps_dir,
>>   			    &psu->debugfs_entries[CFFPS_DEBUGFS_SN],
>>   			    &ibm_cffps_fops);
>> +	debugfs_create_file("max_power_out", 0444, ibm_cffps_dir,
>> +			    &psu->debugfs_entries[CFFPS_DEBUGFS_MAX_POWER_OUT],
>> +			    &ibm_cffps_fops);
>>   	debugfs_create_file("ccin", 0444, ibm_cffps_dir,
>>   			    &psu->debugfs_entries[CFFPS_DEBUGFS_CCIN],
>>   			    &ibm_cffps_fops);
>>   	debugfs_create_file("fw_version", 0444, ibm_cffps_dir,
>>   			    &psu->debugfs_entries[CFFPS_DEBUGFS_FW],
>>   			    &ibm_cffps_fops);
>> +	debugfs_create_file("on_off_config", 0644, ibm_cffps_dir,
>> +			    &psu->debugfs_entries[CFFPS_DEBUGFS_ON_OFF_CONFIG],
>> +			    &ibm_cffps_fops);
>>   
>>   	return 0;
>>   }
