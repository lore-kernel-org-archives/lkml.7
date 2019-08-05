Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B11BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279BB2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfHEOkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:40:55 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:43799 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbfHEOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:40:54 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hueAP-00089V-En; Mon, 05 Aug 2019 08:40:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hueAD-0006yY-3G; Mon, 05 Aug 2019 08:40:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        security@kernel.org, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <20190725130113.GA12932@kroah.com>
        <nycvar.YFH.7.76.1908040214090.5899@cbobk.fhfr.pm>
Date:   Mon, 05 Aug 2019 09:40:21 -0500
In-Reply-To: <nycvar.YFH.7.76.1908040214090.5899@cbobk.fhfr.pm> (Jiri Kosina's
        message of "Sun, 4 Aug 2019 02:17:00 +0200 (CEST)")
Message-ID: <87blx3n0a2.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hueAD-0006yY-3G;;;mid=<87blx3n0a2.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/734h3jRw/GfGy5IwgZetr3oaBMoj7LHI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] Documentation/admin-guide: Embargoed hardware security issues
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I skimmed this and a couple things jumped out at me.

1) PGP and S/MIME because of their use of long term keys do not provide
   forward secrecy.  Which can makes it worth while to cryptographically
   factor a key or to obtain knowledge of a private key without the key
   holders knowledge.  As the keys will be used again and again over a
   long period of time.

   More recent protocol's such as Signal's Double Ratchet Protocol
   enable forward secrecy for store and foward communications, and
   remove the problem of long term keys.

2) The existence of such a process with encrypted communications to
   ensure long term confidentiality is going to make our contact people
   the targets of people who want access to knolwedge about hardware
   bugs like meltdown, before they become public.

I am just mentioning these things in case they are not immediately
obvious to everyone else involved, so that people can be certain
they are comfortable with the tradeoffs being made.

Eric
