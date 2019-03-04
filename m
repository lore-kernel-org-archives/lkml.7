Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5AF20815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfCDFex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:34:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfCDFew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 00:34:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98D17308625A;
        Mon,  4 Mar 2019 05:34:52 +0000 (UTC)
Received: from localhost (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 320705D71A;
        Mon,  4 Mar 2019 05:34:50 +0000 (UTC)
Date:   Mon, 4 Mar 2019 13:34:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de
Subject: Re: [PATCH] x86/boot: Fix incorrect ifdeffery scope
Message-ID: <20190304053448.GX14858@MiWiFi-R3L-srv>
References: <20190304041820.14409-1-bhe@redhat.com>
 <20190304053255.GC28322@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304053255.GC28322@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 04 Mar 2019 05:34:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/19 at 01:32pm, Chao Fan wrote:
> On Mon, Mar 04, 2019 at 12:18:20PM +0800, Baoquan He wrote:
> >The declarations related to immovable memory handling are put out of
> >
> >Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> Are there some problems in your mail tool?
> I can only see one line in the PATCH log and seems a half sentence.

Yeah, just notice it. I will send a new one. Sorry.
