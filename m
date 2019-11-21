Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77747C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535FA208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKUMoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:44:15 -0500
Received: from snd00003.auone-net.jp ([111.86.247.3]:11651 "EHLO
        dmta0002.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726358AbfKUMoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:44:15 -0500
Received: from ppp.dion.ne.jp by dmta0002.auone-net.jp with ESMTP
          id <20191121124413687.NRXY.44544.ppp.dion.ne.jp@dmta0002.auone-net.jp>;
          Thu, 21 Nov 2019 21:44:13 +0900
Date:   Thu, 21 Nov 2019 21:44:13 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Fix !DEBUG_FS debugfs_create_automount
References: <20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp>
 <20191121115232.GC427938@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121115232.GC427938@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Message-Id: <20191121124413687.NRXY.44544.ppp.dion.ne.jp@dmta0002.auone-net.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-21 12:52:32 +0100, Greg Kroah-Hartman wrote:
> 
> Has this always been a problem, or did it just show up due to some other
> kernel change?
> 

The latter. Please see https://lkml.org/lkml/2019/11/21/11

> thanks,
> 
> greg k-h
