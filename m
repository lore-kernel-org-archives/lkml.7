Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F26C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC952184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555021322;
	bh=abD3u4yTSrT+p4xKIErOvga70MdiFtqQa7xI8OAof+c=;
	h=Subject:From:To:Date:List-ID:From;
	b=ytKyXJM/0FSviGn3g1sMeqGW1sEhnzi9OfBbjg4vIZLDZf9n6NNAidcJZXF0KXGeN
	 2SqZ9WbDUmiln6qWQrPg3KjaL+mbrExLGmTvrpwXIUnefLCyho8jCZzduBI2e0ZZeu
	 aq+GzuiQtHx5fZ7j3xS4+SliUT6E06fIzhMsimfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfDKWWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfDKWWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:22:00 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35DAF2146F;
        Thu, 11 Apr 2019 22:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555021320;
        bh=abD3u4yTSrT+p4xKIErOvga70MdiFtqQa7xI8OAof+c=;
        h=Subject:From:To:Date:From;
        b=ue9/PAjqDtqyPsG2fYv0S7NqZJSqBEo1JJZb7o2mfpoLVzUsBE8rgHWFBwIt07EfO
         QbKmytI0wupSRFNFVaZQP+VTpyr5JUmNR0n0DlaBlfzBIqoPTywUDD/Y/2MfiVGRSq
         LiVUw3oZ/IJcjVrMQbEfDA3nhCZeWY9HxfFM1th0=
Message-ID: <1555021318.12566.17.camel@kernel.org>
Subject: [ANNOUNCE] 3.18.138-rt115
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Date:   Thu, 11 Apr 2019 17:21:58 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 3.18.138-rt115 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: 0b31ad979fb6e00b1aa16f873c05fa2cb486b00f

Or to build 3.18.138-rt115 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.138.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.138-rt115.patch.xz


Enjoy!

   Tom
