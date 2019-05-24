Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA15FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FAC21848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390053AbfEXP6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389385AbfEXP6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:58:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 949DC217D7;
        Fri, 24 May 2019 15:58:54 +0000 (UTC)
Date:   Fri, 24 May 2019 11:58:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jason Behmer <jbehmer@google.com>
Cc:     tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: Nested events with zero deltas, can use absolute timestamps
 instead?
Message-ID: <20190524115853.3bf7c248@gandalf.local.home>
In-Reply-To: <20190524115428.2bf41725@gandalf.local.home>
References: <CAMmhGqKc27W03roONYXhmwB0dtz5Z8nGoS2MLSsKJ3Zotv5-JA@mail.gmail.com>
        <20190329125258.2c6fe0cb@gandalf.local.home>
        <CAMmhGqKPw1sxB_Qc+Z-MXZue+wtAQsQDDgUvjs4JQTVY8bR65g@mail.gmail.com>
        <20190401222056.3da6e7a7@oasis.local.home>
        <CAMmhGqL0tvxW_ucJUFKYqRrMRTTfUfRGpm1BnXiEvqFntSXSjQ@mail.gmail.com>
        <CAMmhGq+8XKBB9GA3J0pwZ6X6Qb1syxKVqNU6i6digtyjMrGyWw@mail.gmail.com>
        <20190524110048.142efd44@gandalf.local.home>
        <CAMmhGq+1gZvzR9RwJ6m1MzO1jnTy8yFx8jaRiWpGtZ=E6n9vig@mail.gmail.com>
        <20190524112457.58b24d89@gandalf.local.home>
        <CAMmhGqK7LxvR2t=v3NY5Um+EPurtbSfkpPtCAhDagFs_Sz0Kuw@mail.gmail.com>
        <20190524115428.2bf41725@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 11:54:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I mean the options in tracefs/options/*
> 

Come to think of it, the timestamp_mode probably should have been an
option instead.

-- Steve
