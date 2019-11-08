Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39027C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E9D214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbfKHJhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:37:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730616AbfKHJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:37:17 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA89YEEq106494
        for <linux-kernel@vger.kernel.org>; Fri, 8 Nov 2019 04:37:16 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w539ndcc7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 04:37:11 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alistair@popple.id.au>;
        Fri, 8 Nov 2019 09:36:01 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Nov 2019 09:35:56 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA89ZtUe53936164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 09:35:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79B7CA4055;
        Fri,  8 Nov 2019 09:35:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 308F3A4040;
        Fri,  8 Nov 2019 09:35:55 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Nov 2019 09:35:55 +0000 (GMT)
Received: from townsend.localnet (unknown [9.81.221.11])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 9680AA0278;
        Fri,  8 Nov 2019 20:35:52 +1100 (AEDT)
From:   Alistair Popple <alistair@popple.id.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: Re: [PATCH v2 08/11] dt-bindings: fsi: Add description of FSI master
Date:   Fri, 08 Nov 2019 20:23:20 +1100
In-Reply-To: <20191108051945.7109-9-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au> <20191108051945.7109-9-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19110809-4275-0000-0000-0000037BEAE6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110809-4276-0000-0000-0000388F3ECA
Message-Id: <1939926.rcMDTATi7v@townsend>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alistair Popple <alistair@popple.id.au>

On Friday, 8 November 2019 4:19:42 PM AEDT Joel Stanley wrote:
> This describes the FSI master present in the AST2600.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../bindings/fsi/fsi-master-aspeed.txt        | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt b/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> new file mode 100644
> index 000000000000..b758f91914f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> @@ -0,0 +1,24 @@
> +Device-tree bindings for AST2600 FSI master
> +-------------------------------------------
> +
> +The AST2600 contains two identical FSI masters. They share a clock and have a
> +separate interrupt line and output pins.
> +
> +Required properties:
> + - compatible: "aspeed,ast2600-fsi-master"
> + - reg: base address and length
> + - clocks: phandle and clock number
> + - interrupts: platform dependent interrupt description
> + - pinctrl-0: phandle to pinctrl node
> + - pinctrl-names: pinctrl state
> +
> +Examples:
> +
> +    fsi-master {
> +        compatible = "aspeed,ast2600-fsi-master", "fsi-master";
> +        reg = <0x1e79b000 0x94>;
> +	interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fsi1_default>;
> +	clocks = <&syscon ASPEED_CLK_GATE_FSICLK>;
> +    };
> 




