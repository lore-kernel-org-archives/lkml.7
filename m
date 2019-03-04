Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB05C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332A42082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfCDESs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 23:18:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfCDESs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 23:18:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 640E53082E44;
        Mon,  4 Mar 2019 04:18:48 +0000 (UTC)
Received: from localhost (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78DF65D70A;
        Mon,  4 Mar 2019 04:18:47 +0000 (UTC)
Date:   Mon, 4 Mar 2019 12:18:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org
Subject: Re: A quesiton about commit 3a63f70bf4c3
Message-ID: <20190304041844.GW14858@MiWiFi-R3L-srv>
References: <20190301060631.GU14858@MiWiFi-R3L-srv>
 <20190304012710.GB28322@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304012710.GB28322@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 04 Mar 2019 04:18:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/19 at 09:27am, Chao Fan wrote:
> On Fri, Mar 01, 2019 at 02:06:31PM +0800, Baoquan He wrote:
> >
> >Hi Chao,
> Hi Baoquan,
> 
> Sorry for late reply, I was away from keyboard last Friday.
> Your change looks good, I think you can format it as a real PATCH.

Thx, sent.
