Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ACDC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 14:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E752075C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 14:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="q9V6nwmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfEZOls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 10:41:48 -0400
Received: from mx1.cock.li ([185.10.68.5]:37135 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727778AbfEZOlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 10:41:47 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1558881704; bh=VZYz/b3n8O+CzsVrM5ITA4tioX+X1d5/ib7o4currEg=;
        h=Date:From:To:Cc:Subject:From;
        b=q9V6nwmbCw7CErg9SeeyJL5sjVfRUGCsSzJjQMsb+zzNMyWPLNiExYPU6vNtWg4of
         cUe78czbd82ht+mfEWlFUGeFCuvoXe6x2BwUWO6wyVgUvpFfDEA55SCw3edc7M2B4X
         IiuGH8ABzggvUhcPA8IW92h94r2e4xvrtHqbJ74/Hz6jncDkutHpfZAgJdICi3eG9J
         ShZUW6fauRFvWiniAb34LSBreWv9SHuH5jRFOWSgzRwkQV3ZS/tZ9pLh/jb3VS77mK
         qaz9UusvyXZThMLMonSeNSVxd/ahVQUugchUiMkN+zF49/wfAw6mT3exYlgOaQ1Iiv
         EoQCmmBJX83vQ==
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 26 May 2019 14:41:44 +0000
From:   mikeeusa@redchan.it
To:     Jeff.Read@expertcm.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Revokist
Message-ID: <f843ccfd3c98f87e580272b816430b04@redchan.it>
X-Sender: mikeeusa@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you still want to open that can of worms, mikee?
Yes



> Jeff Read on 2019-05-20 at 11:10:59 said:
> 
> If the revokists are right, think of the implications: The maintainers 
> of Node.js, Go, Rust, or Linux may decide to apply their CoC to all 
> users of their software, and revoke the license to use the software 
> from persons or entities they deem to be violating, or at risk of 
> violating, the CoC. (That's the new hotness: preëmptive disciplinary 
> action against persons deemed to be "at risk" of CoC violations.)
> 
> Do you still want to open that can of worms, mikee? Because I don't 
> think things will turn out the way you hope they will.
http://esr.ibiblio.org/?p=8317
