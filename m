Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D64C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E021B218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfCVIeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:34:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbfCVIeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:34:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FA6731688FD;
        Fri, 22 Mar 2019 08:34:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A0DB60123;
        Fri, 22 Mar 2019 08:34:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190321220009.29334-13-andi@firstfloor.org>
References: <20190321220009.29334-13-andi@firstfloor.org> <20190321220009.29334-1-andi@firstfloor.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     dhowells@redhat.com, x86@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 12/17] afs: Avoid section confusion in CM_NAME
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14980.1553243648.1@warthog.procyon.org.uk>
Date:   Fri, 22 Mar 2019 08:34:08 +0000
Message-ID: <14981.1553243648@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 22 Mar 2019 08:34:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <andi@firstfloor.org> wrote:

> __tracepoint_str cannot be const because the tracepoint_str
> section is not read-only. Remove the stray const.
> 
> Cc: dhowells@redhat.com
> Cc: viro@zeniv.linux.org.uk
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: David Howells <dhowells@redhat.com>
