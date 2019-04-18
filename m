Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B929C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04A620693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555624396;
	bh=hFKE+Io9dlSaCKxpy9gB2JcijN0hWK1Gn4b1pIVnMBM=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=B+K7aXcdsuDvPU31LGJL2VkTNkKKfbhJ1oVPAszaLJiB2UgZu4BocyiL2F+CtJLDd
	 ZNy1GhZFDzrYg2YWbc0Z7ScT2yLW+s3LPng3Aglm87ra7Z2oaKbPOp14tlwMaXrhzh
	 yibAHWfiMNHM2P8gc4zKk++b6C3WzYIdQd1vAp94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfDRVxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfDRVxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:53:15 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1DE020693;
        Thu, 18 Apr 2019 21:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555624394;
        bh=hFKE+Io9dlSaCKxpy9gB2JcijN0hWK1Gn4b1pIVnMBM=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=BKPrGJrfxoZ153wRm0DqFHuuFo8KsBsC8zxddbUMz642GHwCBjVqrwLIS9dLhVDEI
         8SFhbLr7EFxDLg/pEqr01jqx8W6Pumtu51pOX9hEgT44aC13ksTkoTfbEwLdrotc4q
         GcI43N/+LJc1Sfi5/DzO6Wwx00jCCG/YqETwoOBk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190416115616.31861-1-colin.king@canonical.com>
References: <20190416115616.31861-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: mvebu: fix spelling mistake "gatable" -> "gateable"
To:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Message-ID: <155562439394.15276.14861457682549040480@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 18 Apr 2019 14:53:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2019-04-16 04:56:16)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There are a few spelling mistakes in comments and a pr_err
> error message. Fix these.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to clk-next

