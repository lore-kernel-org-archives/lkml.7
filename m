Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB125C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B1E2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551811274;
	bh=WqIr+6BN88dd67F1g0Mcn3mw1B9FyQUOd3nzhpJjo3o=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=jeO+zMqPpuZrTDtFvb/OV5fq5VhAzuYhBrgXdJwASycHwgX135cZ/YlqMqtX0/xgS
	 7ylx2b53Scp9qU3UwL+Bt2scxaZmedc7XNa9oeUmlGzBAdeQQD7SaXHcsI6lIw1P05
	 udHepv2WzOr86nnGlHaHCXSi88wG17p9Hat/j/L4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfCESlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:41:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfCESlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:41:12 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940E62087C;
        Tue,  5 Mar 2019 18:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551811271;
        bh=WqIr+6BN88dd67F1g0Mcn3mw1B9FyQUOd3nzhpJjo3o=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=gGc9AwUKkf1QvnYVX+GyYvbO76V0/jqpBbcqQAkElk0B3Nxj7+JBHlgY4B/DZ6F2f
         tc48ZzsHfXzPml4Z4TPT/uJd86+3tdwxsEcs3whuw/A/A4M0pjJQrInrOGAPU1NDTd
         g9tHYKyc9yQvbf3hiaYWQ3wUwVZ71tKyo9GHxDwo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190305050546.23431-2-weiyi.lu@mediatek.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com> <20190305050546.23431-2-weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 0/9] Mediatek MT8183 clock support
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org,
        Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Message-ID: <155181127087.20095.2938803707449836200@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 05 Mar 2019 10:41:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2019-03-04 21:05:37)
> Resend clock patches from v4 based on v5.0-rc1.
>=20

Please stop sending two cover letters with the same content. Is there
something different about your git-send-email workflow that's causing
this? Hopefully git itself isn't doing this.
