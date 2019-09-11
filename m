Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF54C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A1B20872
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568202366;
	bh=TgGP6K2sExQU7B6iYcL9MelWWYE5pjNpEfLTHO3R/JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QL2BCkd82jaOVYcePble3JRbN9Q7sLtGP6PjNEKbww8GZpoyLfPSFZuWQUaF88JAx
	 W9FnihPIvivO2gmZgznrn++EvwACJt0gtjXvD4KloDq0nVyJ1BbmikItxAoPyua0Vp
	 y/+pLYG2dNYuLCdT4DC72na7owhmtkLXCMWXhJcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfIKLqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 07:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfIKLqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:46:05 -0400
Received: from linux-8ccs.fritz.box (unknown [92.117.136.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ED6A20872;
        Wed, 11 Sep 2019 11:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568202364;
        bh=TgGP6K2sExQU7B6iYcL9MelWWYE5pjNpEfLTHO3R/JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCXUge6pjNEkchBQlIqE4hhWnFB65QKP0m8fn389qNMdcEzShXq1d6Wv05Isv+XCJ
         sSz7lI0ojbN47k4Z4rTuYK1+IZvrJhVy+HV7YVyKYAoJV5Cigzbj+C3YqeMGuambE7
         1Wx4Q4RuJFy41/N1ecNtPFkpAQ3amPLGQ64Ria8s=
Date:   Wed, 11 Sep 2019 13:45:59 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] module: remove redundant 'depends on MODULES'
Message-ID: <20190911114559.GA6189@linux-8ccs.fritz.box>
References: <20190909110408.21832-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190909110408.21832-1-yamada.masahiro@socionext.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [09/09/19 20:04 +0900]:
>These are located in the 'if MODULES' ... 'endif' block.
>
>Remove the redundant dependencies.
>
>Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Jessica Yu <jeyu@kernel.org>

