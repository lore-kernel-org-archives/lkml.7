Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F9C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3D42084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U62KzK9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDLL1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:27:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54410 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLL13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:27:29 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3CBQZJS070136;
        Fri, 12 Apr 2019 06:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555068395;
        bh=C8NicnX7qTjTkacOa+c7ivgtLiisgWi6IhPAanFevEQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=U62KzK9R9EfKh4V/CwA+Xbd6wlYc5D6SIJGG60EwqwrJBrwqruQ0b21jhtXAK9KEa
         TcIVKpDZeHWEkeKRriexHK5RzGOzBAphcrrGxFhpugtitStYr4ZZ5FQUY44xN5rtz9
         clteeAcnGoTy8zgQjhvjJ1OSueYkGhZSDG70olYo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3CBQZL9034869
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 06:26:35 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 06:26:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 06:26:35 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3CBQVtt007152;
        Fri, 12 Apr 2019 06:26:31 -0500
Subject: Re: [PATCH v3 1/3] ARM: dts: da850: add cpu node and operating points
 to DT
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190408075924.2284-1-brgl@bgdev.pl>
 <20190408075924.2284-2-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <5f72a26b-428a-c50e-cb6a-7c888ea22329@ti.com>
Date:   Fri, 12 Apr 2019 16:56:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408075924.2284-2-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On 08/04/19 1:29 PM, Bartosz Golaszewski wrote:
> From: David Lechner <david@lechnology.com>
> 
> This adds a cpu node and operating points to the common da850.dtsi file.
> 
> Additionally, a regulator is added to the LEGO EV3 board along with
> some board-specific CPU configuration.
> 
> Regulators need to be hooked up on other boards to get them working.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I remember you mentioning about some problems using OCHI and cpufreq
together. Are those resolved now? CPU PLL on DA850 can affect other
peripheral clock frequencies too. So enabling it should really be a
per-board decision.

No problems with adding OPPs to da850.dtsi, but which of those are
enabled on any board should be after some thorough testing and analysis.

Because of that, I think its also better to split da850.dtsi from board
specific changes in this patch.

> +	opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp_100: opp100-100000000 {
> +			opp-hz = /bits/ 64 <100000000>;
> +			opp-microvolt = <1000000 950000 1050000>;
> +		};
> +
> +		opp_200: opp110-200000000 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <1100000 1050000 1160000>;
> +		};
> +
> +		opp_300: opp120-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			opp-microvolt = <1200000 1140000 1320000>;
> +		};
> +
> +		/*
> +		 * Original silicon was 300MHz max, so higher frequencies
> +		 * need to be enabled on a per-board basis if the chip is
> +		 * capable.
> +		 */
> +
> +		opp_375: opp120-375000000 {
> +			status = "disabled";
> +			opp-hz = /bits/ 64 <375000000>;
> +			opp-microvolt = <1200000 1140000 1320000>;
> +		};
> +
> +		opp_415: opp130-415000000 {
> +			status = "disabled";
> +			opp-hz = /bits/ 64 <415000000>;
> +			opp-microvolt = <1300000 1250000 1350000>;
> +		};
> +
> +		opp_456: opp130-456000000 {
> +			status = "disabled";
> +			opp-hz = /bits/ 64 <456000000>;
> +			opp-microvolt = <1300000 1250000 1350000>;
> +		};

Here, lets stick to OPPs defined in OMAP-L138 data manual (irrespective
of what existing board code has). Page 93 of
http://www.ti.com/lit/ds/symlink/omap-l138.pdf

Thanks,
Sekhar
