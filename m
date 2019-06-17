Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C18C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0794420833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xDyYRN65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfFQWTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:19:00 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34980 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfFQWTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MmNUBAcapnWmnMp45QnWIpxu2KfpFe5ke1zaBCdGC+E=; b=xDyYRN65bP5x1n5lfLPDMUYTPP
        4PotiD8auEcgLaKMHt9KNvt7nRvAmd1caTjVUqUBYEEW6obJCJp4x8M6U+o9wgRJRL7cHspqfb72e
        IYN9krUqQ/JaoxuzXc+QwP4TmnlY59Ue+Xhi8rsbWUgI5FbvPiz0IfZLZpEMMMJBCA7A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hczxb-0004LJ-Om; Tue, 18 Jun 2019 00:18:43 +0200
Date:   Tue, 18 Jun 2019 00:18:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linus.walleij@linaro.org,
        jason@lakedaemon.net, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: clock: mvebu: Add compatible string
 for 98dx1135 core clock
Message-ID: <20190617221843.GM25211@lunn.ch>
References: <20190617215458.32688-1-chris.packham@alliedtelesis.co.nz>
 <20190617215458.32688-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617215458.32688-3-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 09:54:56AM +1200, Chris Packham wrote:
> Add compatible string for the core clock on the 98dx1135 switch with
> integrated CPU.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
