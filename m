Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF85C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C590220830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfDJWKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:10:13 -0400
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:36066 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725782AbfDJWKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:10:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id D863A100E86C6;
        Wed, 10 Apr 2019 22:10:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coil20_1ea913ba2a849
X-Filterd-Recvd-Size: 1406
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Apr 2019 22:10:10 +0000 (UTC)
Message-ID: <e735fb3399d9fadf75216ef5cb4a7f55d1f336f3.camel@perches.com>
Subject: Re: [PATCH 18/22] watchdog: mt7621_wdt: Use 'dev' instead of
 dereferencing it repeatedly
From:   Joe Perches <joe@perches.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Wed, 10 Apr 2019 15:10:09 -0700
In-Reply-To: <20190410195409.GA29802@roeck-us.net>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
         <1554913683-25454-19-git-send-email-linux@roeck-us.net>
         <e76117d45b1b1caff6bce8d28506e683694d6a79.camel@perches.com>
         <20190410195409.GA29802@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-10 at 12:54 -0700, Guenter Roeck wrote:
> A checkpatch rule suggesting that multiple extension lines can be merged
> might be useful to help finding such situations. Just a thought.

You are welcome to try to write that one.
It's likely not a trivial task to make it sensible.

cheers, Joe

