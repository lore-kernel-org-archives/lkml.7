Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6710C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7328920989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566200623;
	bh=pyovwj0ULanQn79gsy+GBs1g4uJGk78tSpphAigMsE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aEFPBHGZauMnmM9LXELAL8MsSI10eEmj5ek0WZflg/I8w+PS07KnRSe9DgC9gjKSW
	 JQPyzuX//y1flEcSrghNsfY6FpRW+dMXmAeHwh80F3N1p3N/rRkn2D8acN+yqd3tjG
	 ARVvan6NBfOr506jwCuKVbqyStfrJv6m4A69SL64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfHSHnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfHSHnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:43:41 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30DD0204EC;
        Mon, 19 Aug 2019 07:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566200621;
        bh=pyovwj0ULanQn79gsy+GBs1g4uJGk78tSpphAigMsE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IqbnLwxiPiSbiKGrG4stTDREeaJ6TT0GyLfMjtpeOl3KBpIrgalkOejkH4ORpdYL+
         JJDBf7MaDNgaM7/eBWwQF7mii7kb1zBHkHpBPVEyDYfx2hQiZfl6e/m/aQgOdLLIrn
         9fgTShtw5UU+LaKnrw9JRKh7GzvBoMahDlrfelgw=
Date:   Mon, 19 Aug 2019 09:43:28 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: dts: ls1088a: Fix incorrect I2C clock divider
Message-ID: <20190819074327.GD5999@X250>
References: <20190806084223.23543-1-chuanhua.han@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806084223.23543-1-chuanhua.han@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 04:42:20PM +0800, Chuanhua Han wrote:
> Ls1088a platform, the i2c input clock is actually platform pll CLK / 8
> (this is the hardware connection), other clock divider can not get the
> correct i2c clock, resulting in the output of SCL pin clock is not
> accurate.
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>

Applied all, thanks.
