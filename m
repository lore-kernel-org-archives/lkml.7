Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D724CCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B020420640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392793AbfJWXqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 19:46:50 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:53368 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389801AbfJWXqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 19:46:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8C573181D3417;
        Wed, 23 Oct 2019 23:46:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: plot32_3b2e9464b9b05
X-Filterd-Recvd-Size: 1614
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 23 Oct 2019 23:46:46 +0000 (UTC)
Message-ID: <dbecfcf9ed62c481bb040c619af3b1ee5a7de848.camel@perches.com>
Subject: Re: [PATCH v4] string-choice: add yesno(), onoff(),
 enableddisabled(), plural() helpers
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Vishal Kulkarni <vishal@chelsio.com>, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date:   Wed, 23 Oct 2019 16:46:45 -0700
In-Reply-To: <20191023155619.43e0013f0c8c673a5c508c1e@linux-foundation.org>
References: <20191023131308.9420-1-jani.nikula@intel.com>
         <20191023155619.43e0013f0c8c673a5c508c1e@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-23 at 15:56 -0700, Andrew Morton wrote:
> And doing this will cause additional savings: calling a single-arg
> out-of-line function generates less .text than calling yesno().

I get no change in size at all with any of
	extern
	static __always_inline
with either of bool or int argument.

gcc 8.3, defconfig with CONFIG_CHELSIO_T4


