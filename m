Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF420C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64C9218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="NlxVAmZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfLTOmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:42:06 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:33835 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfLTOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:42:05 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 995B123D1F;
        Fri, 20 Dec 2019 15:42:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1576852922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26uu/iYvQFOJAnS0060bLZ77XfkUo39xWpFGhKD5fKs=;
        b=NlxVAmZmUO38pfDyNXoynkyFDgU1V0eXyf1nIOlEk9kdTStG9NyOotZfMEhNR8s93LF1hE
        pyLvfMKhWEqp29Xk7ecYyJBg3IwOBjOcMkSEeGoDuYXURcFQB2EDwpr2HRb5aWvhU1F/4y
        1P4YpQn5q+kezks5d/mGVM4kQjvCnG4=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 20 Dec 2019 15:42:02 +0100
From:   Michael Walle <michael@walle.cc>
To:     Wen He <wen.he_1@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [EXT] Re: [v11 2/2] clk: ls1028a: Add clock driver for Display
 output interface
In-Reply-To: <DB7PR04MB519563398D95F64E44E795CEE2500@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20191205072653.34701-1-wen.he_1@nxp.com>
 <20191205072653.34701-2-wen.he_1@nxp.com>
 <20191212221817.B7FF1206DA@mail.kernel.org>
 <F2C21019-79F4-450F-A575-9621E5747C4E@walle.cc>
 <20191216175543.F2C60206B7@mail.kernel.org>
 <DB7PR04MB519563398D95F64E44E795CEE2500@DB7PR04MB5195.eurprd04.prod.outlook.com>
Message-ID: <289c144119601032f701a4560ca1902a@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 995B123D1F
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         NEURAL_HAM(-0.00)[-0.262];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2019-12-17 08:08, schrieb Wen He:
>> -----Original Message-----
>> From: Stephen Boyd <sboyd@kernel.org>
>> Sent: 2019年12月17日 1:56
>> To: Leo Li <leoyang.li@nxp.com>; Mark Rutland <mark.rutland@arm.com>;
>> Michael Turquette <mturquette@baylibre.com>; Michael Walle
>> <michael@walle.cc>; Rob Herring <robh+dt@kernel.org>; Wen He
>> <wen.he_1@nxp.com>; devicetree@vger.kernel.org; 
>> linux-clk@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: [EXT] Re: [v11 2/2] clk: ls1028a: Add clock driver for 
>> Display output
>> interface
>> 
>> Caution: EXT Email
>> 
>> Quoting Michael Walle (2019-12-12 16:06:16)
>> > Am 12. Dezember 2019 23:18:16 MEZ schrieb Stephen Boyd
>> <sboyd@kernel.org>:
>> > >Quoting Wen He (2019-12-04 23:26:53)
>> > >> Add clock driver for QorIQ LS1028A Display output interfaces(LCD,
>> > >DPHY),
>> > >> as implemented in TSMC CLN28HPM PLL, this PLL supports the
>> > >programmable
>> > >> integer division and range of the display output pixel clock's
>> > >27-594MHz.
>> > >>
>> > >> Signed-off-by: Wen He <wen.he_1@nxp.com>
>> > >> Signed-off-by: Michael Walle <michael@walle.cc>
>> > >
>> > >Is Michael the author? SoB chain is backwards here.
>> >
>> > the original driver was from Wen. I've just supplied some code and the
>> > vco frequency stuff. so its basically a sob of us both.
>> >
>> > -michael
>> 
>> Ok. That's a Co-developed-by: tag then. Thanks for letting us know.
> 
> The v12 version patch was sent out.
> Does need I change the author sign to below?

I guess you mean the MODULE_AUTHOR()? I don't care if you add me or not,
so do as you like.

> Co-developed-by: Wen He <wen.he_1@nxp.com>
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> Co-developed-by: Michael Walle <michael.@walle.cc>
> Signed-off-by: Michael Walle <michael.@walle.cc>
> Signed-off-by: Wen He <wen.he_1@nxp.com>

Judging by the other Co-developed-by: lines it should be

Co-developed-by: Michael Walle <michael.@walle.cc>
Signed-off-by: Michael Walle <michael.@walle.cc>
Signed-off-by: Wen He <wen.he_1@nxp.com>

-michael
