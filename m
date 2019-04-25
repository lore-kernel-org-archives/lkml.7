Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52D7C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B4120878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556217812;
	bh=D/VAesWQuX5fO5fvOJ8aNcrrgHK/xzsBeqeQBLK5IRY=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=h2y6t5Yykd/T1Ai4jv0Ozo3JGudmuCrjCizIXtdhqNwX3du87fOSUIcL1GTl+oenM
	 j7e8xXo2H43jfsVH1eDxo6QRMmunAWVyB3qdFQotkqX2uvBC7eMUxXwr/7EsHFzAU/
	 ox8i1AV4hMbB9xGKrfvSzQ1jDdlxEvDEH1FxXVDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfDYSna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYSn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:43:29 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94B302084F;
        Thu, 25 Apr 2019 18:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556217809;
        bh=D/VAesWQuX5fO5fvOJ8aNcrrgHK/xzsBeqeQBLK5IRY=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=oxgYaXnELfZNRoP6OogjLla60GzSZ5e6UCRPgBQSTLrpzxSd5Yor6+EKBXvCPsfEk
         qAiDZNHoWn71qTAqyE7oE6sdqc6QD38fBCIkonEAE+mFSlg2Wk0FZ8DVpx3owg8iku
         l1XaVfOJLh4HvRGi1ZbGbHQFsg+nOfqucgO6rQMU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190219170200.3608-3-alexandre.belloni@bootlin.com>
References: <20190219170200.3608-1-alexandre.belloni@bootlin.com> <20190219170200.3608-3-alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/7] clk: at91: modernize sckc binding
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <155621780833.15276.15655289006758205903@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 11:43:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-02-19 09:01:55)
> Remove the need for child nodes in the sckc binding and register the whole
> sckc tree (3 clocks in total) from the sckc node.
>=20
> DT backward compatibility is kept by looking for properties in child nodes
> when they are not present in the sckc node.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

