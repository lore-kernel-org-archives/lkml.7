Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630DAC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C8E214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568782880;
	bh=sJyenI3h9yhijDKofovjzzH4KAe+8VnNMcspDIixjOo=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=GU1Zd1U/12dZ5Tufi4qmBi3Ry8tbyJ4aBNEPZHfIVVU/h+WnUFYMmtYAunbyhPIAI
	 cdO48E/QL31ETG6AWFtUne4Wnw1Tj/rykuIYY0tR2rHNyBdylVtcTv7Enr/SiV01K7
	 ctNd8728smlem6m6k5cDdQodm+j79vOCwJfAJg2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfIRFBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 01:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfIRFBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 01:01:19 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6639120882;
        Wed, 18 Sep 2019 05:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568782878;
        bh=sJyenI3h9yhijDKofovjzzH4KAe+8VnNMcspDIixjOo=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=S+yrQ80DFOGRIvIm7U4EG9xiBXTcu5Ld20fFDWmsSZWTjGHuXEnMd6ltm9MkNWUuX
         Ld0u7YvkFbRZ+BPu+9KOJPBp+V95IZzHk9mQcdX2bhHD5a2sMTQ6vQovh+P78LVzbS
         zD3myZTytDL/ZpgaDICuq48QeMnpGyCO982C4ViE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190905103009.27166-1-zhang.lyra@gmail.com>
References: <20190905103009.27166-1-zhang.lyra@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: sprd: add missing kfree
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 22:01:17 -0700
Message-Id: <20190918050118.6639120882@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2019-09-05 03:30:09)
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>=20
> The number of config registers for different pll clocks probably are not
> same, so we have to use malloc, and should free the memory before return.
>=20
> Fixes: 3e37b005580b ("clk: sprd: add adjustable pll support")
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
> ---

Applied to clk-next

