Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2025C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30BD206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfJGPcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:32:10 -0400
Received: from ms.lwn.net ([45.79.88.28]:57960 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbfJGPcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:32:10 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 803B2316;
        Mon,  7 Oct 2019 15:32:09 +0000 (UTC)
Date:   Mon, 7 Oct 2019 09:32:08 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Gerald BAEZA <gerald.baeza@st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: add link to stm32mp157 docs
Message-ID: <20191007093208.757554b0@lwn.net>
In-Reply-To: <8d097a0486e94257952600bf6d20975d@SFHDAG5NODE1.st.com>
References: <1566908347-92201-1-git-send-email-gerald.baeza@st.com>
        <20190827074825.64a28e88@lwn.net>
        <5257eff7-418b-8e94-1ced-30718dd3f5dc@st.com>
        <8d097a0486e94257952600bf6d20975d@SFHDAG5NODE1.st.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2019 10:05:46 +0000
Gerald BAEZA <gerald.baeza@st.com> wrote:

> > > Adding the URL is a fine idea.  But you don't need the extra syntax to
> > > create a link if you're not going to actually make a link out of it.
> > > So I'd take the ".. _STM32MP157:" part out and life will be good.
> > >  
> > 
> > We also did it for older stm32 product. Idea was to not have the "full"
> > address but just a shortcut of the link when html file is read. It maybe makes
> > no sens ? (if yes we will have to update older stm32 overview :))  
> 
> Example in https://www.kernel.org/doc/html/latest/arm/stm32/stm32h743-overview.html
> 
> Do you agree to continue like this ?

If you actually use the reference then it's OK, I guess; in the posted
document that wasn't happening.  I still think it might be a bit more
straightforward to just put the URL; that will make the plain-text file a
little more readable.  In the end, though, it's up to you, go with
whichever you prefer.

Thanks,

jon
