Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51994C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D36D206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLSPtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:49:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726789AbfLSPtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:49:04 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJFljJv132736;
        Thu, 19 Dec 2019 10:48:47 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x0a9npec1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 10:48:46 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBJFlulW009200;
        Thu, 19 Dec 2019 15:48:46 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 2wvqc7be7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 15:48:46 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBJFmirc55050534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 15:48:44 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87DF8BE053;
        Thu, 19 Dec 2019 15:48:44 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1860DBE04F;
        Thu, 19 Dec 2019 15:48:43 +0000 (GMT)
Received: from [9.211.143.195] (unknown [9.211.143.195])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 19 Dec 2019 15:48:43 +0000 (GMT)
Subject: Re: [PATCH v3 05/12] dt-bindings: soc: Add Aspeed XDMA Engine
To:     Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, tglx@linutronix.de,
        Joel Stanley <joel@jms.id.au>
References: <1576681778-18737-1-git-send-email-eajames@linux.ibm.com>
 <1576681778-18737-6-git-send-email-eajames@linux.ibm.com>
 <73cbffea-89f1-4212-99af-10c32968cf15@www.fastmail.com>
From:   Eddie James <eajames@linux.ibm.com>
Message-ID: <45cabf88-063d-aea1-6c2b-fa8cc0d8cbd3@linux.ibm.com>
Date:   Thu, 19 Dec 2019 09:48:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <73cbffea-89f1-4212-99af-10c32968cf15@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_04:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/18/19 5:12 PM, Andrew Jeffery wrote:
>
> On Thu, 19 Dec 2019, at 01:39, Eddie James wrote:
>> Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>> Changes since v2:
>>   - Remove 'sdmc', rename 'vga-mem' to 'memory'
>>
>>   .../devicetree/bindings/soc/aspeed/xdma.txt   | 40 +++++++++++++++++++
>>   MAINTAINERS                                   |  6 +++
>>   2 files changed, 46 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
>> b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
>> new file mode 100644
>> index 000000000000..58253ea1587b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
>> @@ -0,0 +1,40 @@
>> +Aspeed AST25XX and AST26XX XDMA Engine
>> +
>> +The XDMA Engine embedded in the AST2500 and AST2600 SOCs can perform
>> automatic
>> +DMA operations over PCI between the SOC (acting as a BMC) and a host
>> processor.
>> +
>> +Required properties:
>> + - compatible		: must be "aspeed,ast2500-xdma" or
>> +			  "aspeed,ast2600-xdma"
>> + - reg			: contains the address and size of the memory region
>> +			  associated with the XDMA engine registers
>> + - clocks		: clock specifier for the clock associated with the
>> +			  XDMA engine
>> + - resets		: reset specifier for the syscon reset associated with
>> +			  the XDMA engine
>> + - interrupts-extended	: two interrupt cells; the first specifies the
>> global
>> +			  interrupt for the XDMA engine and the second
>> +			  specifies the PCI-E reset or PERST interrupt.
>> + - scu			: a phandle to the syscon node for the system control
>> +			  unit of the SOC
> I think this should be aspeed,scu.


Sure.


>
>> + - memory		: contains the address and size of the memory area to
>> +			  be used by the XDMA engine for DMA operations
> Hmm, I was thinking more like a phandle to a reserved memory region,
> like we have in the aspeed-lpc-ctrl binding.


I think I mentioned before, but that doesn't work with the VGA memory. 
Linux can't reserve it. I haven't quite understood what happens in the 
memory system but I've tried it and it didn't work.


>
>> +
>> +Optional properties:
>> + - pcie-device		: should be either "bmc" or "vga", corresponding to
>> +			  which device should be used by the XDMA engine for
>> +			  DMA operations. If this property is not set, the XDMA
>> +			  engine will use the BMC PCI-E device.
>> +
>> +Example:
>> +
>> +    xdma@1e6e7000 {
>> +        compatible = "aspeed,ast2500-xdma";
>> +        reg = <0x1e6e7000 0x100>;
>> +        clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
>> +        resets = <&syscon ASPEED_RESET_XDMA>;
>> +        interrupts-extended = <&vic 6>, <&scu_ic
>> ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI>;
>> +        scu = <&syscon>;
>> +        pcie-device = "bmc";
>> +        memory = <0x9f000000 0x01000000>;
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ac9c120d192b..8a14d4268bdc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2708,6 +2708,12 @@ S:	Maintained
>>   F:	drivers/media/platform/aspeed-video.c
>>   F:	Documentation/devicetree/bindings/media/aspeed-video.txt
>>   
>> +ASPEED XDMA ENGINE DRIVER
>> +M:	Eddie James <eajames@linux.ibm.com>
>> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/soc/aspeed/xdma.txt
>> +
>>   ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>>   M:	Corentin Chary <corentin.chary@gmail.com>
>>   L:	acpi4asus-user@lists.sourceforge.net
>> -- 
>> 2.24.0
>>
>>
