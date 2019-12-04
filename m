Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B07C2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185412073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfLDXdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:33:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727989AbfLDXdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:33:21 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4NVv6Y097765;
        Wed, 4 Dec 2019 18:32:53 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wpp7q8fsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 18:32:53 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB4NULjT021977;
        Wed, 4 Dec 2019 23:32:52 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 2wkg27hn2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 23:32:52 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB4NWpFm34275634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Dec 2019 23:32:51 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 483FD124052;
        Wed,  4 Dec 2019 23:32:51 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C72D6124053;
        Wed,  4 Dec 2019 23:32:50 +0000 (GMT)
Received: from [9.10.101.151] (unknown [9.10.101.151])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  4 Dec 2019 23:32:50 +0000 (GMT)
Subject: Re: [PATCH 1/2] dt-bindings: hwmon/pmbus: Add UCD90320 power
 sequencer
To:     Rob Herring <robh@kernel.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, mark.rutland@arm.com,
        corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Wright <jlwright@us.ibm.com>
References: <20191122222542.29661-1-wrightj@linux.vnet.ibm.com>
 <20191122222542.29661-2-wrightj@linux.vnet.ibm.com>
 <20191204225901.GA20804@bogus>
From:   Jim Wright <wrightj@linux.vnet.ibm.com>
Message-ID: <30187513-85f1-7336-32eb-fc0b19d6b093@linux.vnet.ibm.com>
Date:   Wed, 4 Dec 2019 17:32:49 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191204225901.GA20804@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912040195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 12/4/2019 4:59 PM, Rob Herring wrote:
> On Fri, Nov 22, 2019 at 04:25:41PM -0600, Jim Wright wrote:
>> From: Jim Wright <jlwright@us.ibm.com>
>>
>> Document the UCD90320 device tree binding.
>>
>> Signed-off-by: Jim Wright <jlwright@us.ibm.com>
>> ---
>>   .../devicetree/bindings/hwmon/pmbus/ucd90320.txt    | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/ucd90320.txt
> Can you make this a schema. See
> Documentation/devicetree/writing-schema.rst.
Ok, will do and submit patch set revision.
Thanks for the review,
Jim Wright
>
>> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/ucd90320.txt b/Documentation/devicetree/bindings/hwmon/pmbus/ucd90320.txt
>> new file mode 100644
>> index 000000000000..e1c1057c6292
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/ucd90320.txt
>> @@ -0,0 +1,13 @@
>> +UCD90320 power sequencer
>> +-------------------------
>> +
>> +Requires node properties:
>> +- compatible : "ti,ucd90320"
>> +- reg : the I2C address of the device. This is 0x11, 0x13, 0x17, 0x31, 0x33,
>> +        0x37, 0x71, 0x73, or 0x77.
>> +
>> +Example:
>> +	ucd90320@11 {
>> +		compatible = "ti,ucd90320";
>> +		reg = <0x11>;
>> +	};
>> -- 
>> 2.17.1
>>
