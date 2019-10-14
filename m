Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255CCC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0D020854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571035965;
	bh=ryBaBPoQwcBEQb8d+s/UEB6ik9EIb3YdztJHUWV605s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PrZFOEIjynGBHNMrjbl6J/HO0agwJFJ9RF+YNcYnCPVmRyWgCzij/Z0VolgZUF+d2
	 p0DP+pzM1iZacsM73vuHFuBSDVyHVzmNsti4AXzjej0Hzrr8u2k+nk0U8pAnSv5oI1
	 SOIEuPoIqPulmtiPBKaqmXbXyFDFrn82orQOKZq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfJNGwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfJNGwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:52:43 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C5A820673;
        Mon, 14 Oct 2019 06:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571035962;
        bh=ryBaBPoQwcBEQb8d+s/UEB6ik9EIb3YdztJHUWV605s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p/KvMtroXkV8GiWQIn+dSLyMRFwdNPWAG29vw7nciv0J/g+p7LcbmU9aobj6Ilmwm
         qBz/SqM64cC3/J6WofC0XzsS7O6z4ofdXIO48yqFl0+RFifGVFhTMe5B7fW7QnJHHs
         /fJOMGgEtYaUQmkspNJ5aZ3okx7bS4zaAaFvtPNU=
Date:   Mon, 14 Oct 2019 14:52:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, xiaobo.xie@nxp.com,
        jiafei.pan@nxp.com, Ran Wang <ran.wang_1@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: enable otg mode for dwc3 usb ip on
 layerscape
Message-ID: <20191014065210.GE12262@dragon>
References: <20190924032903.32775-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924032903.32775-1-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 11:29:03AM +0800, Yinbo Zhu wrote:
> layerscape otg function should be supported HNP SRP and ADP protocol
> accroing to rm doc, but dwc3 code not realize it and use id pin to
> detect who is host or device(0 is host 1 is device) this patch is to
> enable OTG mode on ls1028ardb ls1088ardb and ls1046ardb in dts
> 
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 4 ++++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 4 ++++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts | 1 +

This is an arm64 DTS patch, so the patch prefix should be something
like 'arm64 dts: fsl: ...'

Shawn

>  3 files changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index 9fb9113..076cac6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -171,3 +171,7 @@
>  &sata {
>  	status = "okay";
>  };
> +
> +&usb1 {
> +	dr_mode = "otg";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> index 6a6514d..0c742be 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> @@ -122,6 +122,10 @@
>  	};
>  };
>  
> +&usb1 {
> +	dr_mode = "otg";
> +};
> +
>  #include "fsl-ls1046-post.dtsi"
>  
>  &fman0 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> index 8e925df..90b1989 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> @@ -95,5 +95,6 @@
>  };
>  
>  &usb1 {
> +	dr_mode = "otg";
>  	status = "okay";
>  };
> -- 
> 2.9.5
> 
