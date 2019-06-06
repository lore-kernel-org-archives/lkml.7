Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1912AC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E035F20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559861899;
	bh=j/aIV6c/KQbK9cjA0TZlc6ZkLtdHIUPXfcUYnGTZ0rs=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=2hiRg6rURK0l1LupRsO/q/lyICuJG4oTiuv2rospQOSXb+WcYtmMu/qamrJicFjj5
	 n64s9t7CIpDToW9F/gKxKU8mQhku7VTMCnqDxtgXgCLjuiEW1TzlvkOjN9j7/SOOmY
	 1kksia7ZWh6/kAxiSkBsQTE/Kqmcb6gSsjaQ25WA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfFFW6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfFFW6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:58:18 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7557F20645;
        Thu,  6 Jun 2019 22:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559861897;
        bh=j/aIV6c/KQbK9cjA0TZlc6ZkLtdHIUPXfcUYnGTZ0rs=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=WJw5/uyyJTq5dqW5s9gnXfRzUXZA/KzK1Ayqc2AjmRKdRcHZGuL0o1eYVBOkSSpm8
         Y+6Y1/16BzEzbZ9dBjPJ0SLS7M55jdBBbLHxCTox9c5PUY+j0Jd/E74XmogqmnwZxw
         PuGC5pi/3HEuLLJ9Pj4haK0bXibchCWyfAW2EEns=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190521034001.53365-1-erin.lo@mediatek.com>
References: <20190521034001.53365-1-erin.lo@mediatek.com>
To:     Erin Lo <erin.lo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: mediatek: Remove MT8183 unused clock
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 15:58:16 -0700
Message-Id: <20190606225817.7557F20645@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Erin Lo (2019-05-20 20:40:01)
> Remove MT8183 sspm clock
>=20
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---

Applied to clk-next

