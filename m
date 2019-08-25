Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF4FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 07:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B74E20850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 07:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566717358;
	bh=8pqmVNKR1eEG8zWJwqVegtkwFiqBjuE2bxUuKd2gWAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IXU0hFpMidq+uSHMFf4bkViMACpkCwugFlR7DNfvwPbrJSbFF/wPAvmzM9rWhl3LB
	 RhMnsCo14ndLBk3tjDJ9bdjy+5vPRXydqTPT6seq8JeLHgSxvVzN25IEXwqOR2vRPn
	 tRVwgNvCuCDsVNbJty8OLSz+6oqPpL9UsvAu5CqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfHYHP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 03:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfHYHP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 03:15:57 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 905F420850;
        Sun, 25 Aug 2019 07:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566717356;
        bh=8pqmVNKR1eEG8zWJwqVegtkwFiqBjuE2bxUuKd2gWAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jNyNPj3RzhO3eG/nR5IoYVHpEutzU1wJB05NgxkW+aiGgqPdn9b3BWzLcHth8eFLg
         RZKKoY7phAAIdhkdoqPHTWvhBQVyUq53OC6vJ/R3KwQIoan26oy1Hg4Kcky/vdH92g
         LE5uKYf00DKgPgDqrn9fD3//Bv2iva41QBoli8LQ=
Date:   Sun, 25 Aug 2019 09:15:44 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vf610-zii-scu4-aib: Configure IRQ line for
 GPIO expander
Message-ID: <20190825071543.GB5292@X250.getinternet.no>
References: <20190824002703.13902-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824002703.13902-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 05:27:03PM -0700, Andrey Smirnov wrote:
> Configure IRQ line for SX1503 GPIO expander. We already have
> appropriate pinmux entry and all that is missing is "interrupt-parent"
> and "interrupts" properties. Add them.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied, thanks.
