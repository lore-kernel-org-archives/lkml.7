Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D7CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127A920657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfCKOsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:48:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53109 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfCKOsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:48:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 813B9356E8;
        Mon, 11 Mar 2019 14:48:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2572560123;
        Mon, 11 Mar 2019 14:48:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <alpine.DEB.2.21.999.1903080954040.21644@trent.utfs.org>
References: <alpine.DEB.2.21.999.1903080954040.21644@trent.utfs.org> <alpine.DEB.2.21.999.1903060943320.1662@trent.utfs.org> <22096.1551878195@warthog.procyon.org.uk> <alpine.DEB.2.21.999.1903051616350.4505@trent.utfs.org> <10106.1551892803@warthog.procyon.org.uk> <17155.1552056554@warthog.procyon.org.uk>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>
Subject: Re: FS-Cache: Duplicate cookie detected
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2826.1552315718.1@warthog.procyon.org.uk>
Date:   Mon, 11 Mar 2019 14:48:38 +0000
Message-ID: <2827.1552315718@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 11 Mar 2019 14:48:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

I've a couple more patches for you - one a bugfix and one that will print more
information.  They don't actually affect the problem you're seeing.  I'll post
them as replies to this message.

David
