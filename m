Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2939C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C952084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551457458;
	bh=Xh6/dspfEwc85QLun1LjQdXH+HajQ8nXAFFcW91WVj0=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=RlNPcUoOJh/9zShLzaeQbHI5IpTi+xpDjw+JVn1wV7iRmY2eWH1CkIe5NROqcixKk
	 S6LkSRyaO1DnfKwMpgdONLMkr0BgOTAHmYKKrep6LZdeoGafe9tUEOGDYHAR8sSaon
	 tc7fPqR7GQY2hnHpZFplB7+urtoDfE4LxQ5NDVQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389143AbfCAQYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:24:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388450AbfCAQYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:24:16 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C3572083D;
        Fri,  1 Mar 2019 16:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551457456;
        bh=Xh6/dspfEwc85QLun1LjQdXH+HajQ8nXAFFcW91WVj0=;
        h=Subject:From:To:Cc:Date:From;
        b=kuroZxf7jt2G56jSMRxrNCW7IEH2VTGREE93T9Ydb9HISNCRO8BGhRITcGpl2LZ/c
         5a9QgMlpiK58i1CxmiC3k6m8O16g4nsjZQEnvzpKEnjMDYV0fSQpUiz/XdoprG4pIO
         CDROIbE6O8K+qk/aESkrPGGNGHSNrHlQKvPoF7Q8=
Message-ID: <1551457454.3033.13.camel@kernel.org>
Subject: [ANNOUNCE] 3.18.136-rt114
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Julia Cartwright <julia@ni.com>
Date:   Fri, 01 Mar 2019 10:24:14 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 3.18.136-rt114 stable release.

This release is just an update to the new stable 3.18.136 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: f9004c22ef50febe6b537b63e6c42072ebda259b

Or to build 3.18.136-rt114 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.136.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.136-rt114.patch.xz


Enjoy!
   
   Tom
