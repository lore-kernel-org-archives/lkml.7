Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D86CC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2BC20891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556221024;
	bh=5uQLvRXffBbQRuLSviLJ/BP5swdK56aNbPI5TiuSbys=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=VeGgSaO6F/1RdH2gSuayEOz/QzpP5bmSeuWuCGfMS7DvImM0iqqmIYhXimEKtosrD
	 u0Y1OIU9nRh/O+mTbrob9Rr3x4OTddnJyfU48B2nrc8JrDz8/DgVn9cv0xUgEhQOUm
	 XkV3nD+YR7n0FcOijLIHYQQF6HF3Y241NWldpDQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387479AbfDYThD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:37:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYThC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:37:02 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D01FC2077C;
        Thu, 25 Apr 2019 19:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556221021;
        bh=5uQLvRXffBbQRuLSviLJ/BP5swdK56aNbPI5TiuSbys=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=bokq7P3ff3C7RtWHQM5dCbZZuPEBPhpcHWewtO2vJzVr5xSMmH6q4GxjRMUiGwn8W
         BmkeqirsHD5Esr+ghOCYkH/1WpOnAWDYtoy/Tft0O65QIr77YLCEqmWFqamMXYUM0Q
         BBdlNNUDw86MnSqb56a3yRjqvdHzvX4URzSrTxk8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190402125056.21509-3-alexandre.belloni@bootlin.com>
References: <20190402125056.21509-1-alexandre.belloni@bootlin.com> <20190402125056.21509-3-alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/7] clk: at91: allow configuring generated PCR layout
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <155622102065.15276.5013709697832279458@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 12:37:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-04-02 05:50:51)
> The PCR register layout for GCLKCSS is changing for the future SoCs, allow
> configuring it.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

