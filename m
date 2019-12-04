Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788FFC2D0BE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570C820661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfLDWgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:36:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728053AbfLDWgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:36:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4MZtcw079935;
        Wed, 4 Dec 2019 17:35:55 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wnej0veca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 17:30:58 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB4MOnnk012691;
        Wed, 4 Dec 2019 22:29:08 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 2wkg273hkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 22:29:08 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB4MT7Np24838566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Dec 2019 22:29:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D19A3B205F;
        Wed,  4 Dec 2019 22:29:07 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E102AB2065;
        Wed,  4 Dec 2019 22:29:06 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  4 Dec 2019 22:29:06 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Dec 2019 16:29:49 -0600
From:   Adriana Kobylak <anoo@linux.ibm.com>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Adriana Kobylak <anoo@us.ibm.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux-aspeed 
        <linux-aspeed-bounces+anoo=linux.ibm.com@lists.ozlabs.org>
Subject: Re: [PATCH 08/14] ARM: dts: swift: Cleanup gpio-keys-polled
 properties
In-Reply-To: <78ea3e17108c7c8fded921f5673777fc415cd66e.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
 <78ea3e17108c7c8fded921f5673777fc415cd66e.1575369656.git-series.andrew@aj.id.au>
Message-ID: <450addb633e8572a019ccaec5fd48248@linux.vnet.ibm.com>
X-Sender: anoo@linux.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-03 06:04, Andrew Jeffery wrote:
> dtbs_check gave the following warning:
> 
>     Warning (avoid_unnecessary_addr_size): /gpio-keys-polled:
> unnecessary #address-cells/#size-cells without "ranges" or child "reg"
> property
> 
> Cc: Adriana Kobylak <anoo@us.ibm.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Adriana Kobylak <anoo@us.ibm.com>
Tested-by: Adriana Kobylak <anoo@us.ibm.com>

> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-swift.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> index 0831bc1f5a4c..555d79405884 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> @@ -82,8 +82,6 @@
> 
>  	gpio-keys-polled {
>  		compatible = "gpio-keys-polled";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		poll-interval = <1000>;
> 
>  		scm0-presence {
