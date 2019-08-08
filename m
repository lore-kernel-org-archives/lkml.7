Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EF8C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 04:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01A721873
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 04:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565238238;
	bh=eHQ5zzgEL3lSfdpuLPfgScchZvq19sR+WR+ht/F3oS4=;
	h=In-Reply-To:References:From:Cc:To:Subject:Date:List-ID:From;
	b=tyLR7p6fMCFrUKi6Chb8sm11XEh/jO0/QyX39M9Q5D6QILAL1OAHaCXheNIlmxsGt
	 /eccCSgghc60IxcGyd6Kmx4ua7+QUEpIJ2FhVPSfsggCVPaP7CTSdvc9BJy8SvbAwk
	 57TPqANzoHZspxTVanL/jTV8aAaNrjEQO4qRp/E8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfHHEXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 00:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfHHEXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 00:23:55 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5168A21743;
        Thu,  8 Aug 2019 04:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565238234;
        bh=eHQ5zzgEL3lSfdpuLPfgScchZvq19sR+WR+ht/F3oS4=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=Ced5Bz5MI6TJr3ZVXRxx43NoWaS+nj1STKasLcg32Js7/MAcAsVu4jqJFN917//Hf
         lzqIqUaQNNMi7av7dYHkBkkMaEeeRfkWexr+Hijn7sBt5tsWm4I+2ove42SxBgl00N
         +dlLPfGTVOOf1UP+UTxsA0Y4YcdpEStGOoJFjwNc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190716170800.23668-1-paul@crapouillou.net>
References: <20190716170800.23668-1-paul@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic: Use CLK_OF_DECLARE_DRIVER macro
User-Agent: alot/0.8.1
Date:   Wed, 07 Aug 2019 21:23:53 -0700
Message-Id: <20190808042354.5168A21743@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-07-16 10:08:00)
> By using CLK_OF_DECLARE_DRIVER instead of the CLK_OF_DECLARE macro, we
> allow the driver to probe also as a platform driver.
>=20
> While this driver does not have code to probe as a platform driver, this
> is still useful for probing children devices in the case where the
> device node is compatible with "simple-mfd".
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

What's the baseline for this? It doesn't apply cleanly to v5.3-rc1

