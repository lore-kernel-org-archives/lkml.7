Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E24C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4506D21850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555013809;
	bh=hAQnIvKJ5uKfi4IKYAwBCTeQunK/dVLB4pKi0sB9knc=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=SbC1dXvZHVyV74rMvqlS2F2yv3x1Qki9QV0HjKqReM8OBASthqtpEz7W3WT9n+yCY
	 H72xhPyPSAIdjbg3swoVmtqT0CANxE6/ZdkexiopCz60jPv1QwHvbiIzcKmH1TCwhN
	 4cFjzBKVRozqJLIzXCNLOe7wxf5mgZWOwjNoCZW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfDKUQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDKUQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:16:48 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49D9E20850;
        Thu, 11 Apr 2019 20:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555013807;
        bh=hAQnIvKJ5uKfi4IKYAwBCTeQunK/dVLB4pKi0sB9knc=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=zKFGgcv5EFAGCdJwQZnVkrgMrk/M+s619gu0/CUUrxXp3xgCR0jLg3rOMxshpE3gX
         X4ySJFKUJZT19XaE6SdORx4Tk7zOxp08rT8a+XWQVNs3wnI6cVGZvpyS3UsBWiSgzt
         f0vndq+oW11QbCcDRtguzWTJfJuLwyZbBFzO/9oY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190305050546.23431-7-weiyi.lu@mediatek.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com> <20190305050546.23431-7-weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 5/9] clk: mediatek: Add dt-bindings for MT8183 clocks
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
Message-ID: <155501380655.20095.858567311850490088@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 13:16:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2019-03-04 21:05:42)
> Add MT8183 clock dt-bindings, include topckgen, apmixedsys,
> infracfg, mcucfg and subsystem clocks.
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

