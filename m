Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591FDC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A0C20890
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfIPJi1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:38:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfIPJi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:38:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6D6B301A892;
        Mon, 16 Sep 2019 09:38:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-72.rdu2.redhat.com [10.10.125.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92A4A5D9E1;
        Mon, 16 Sep 2019 09:38:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190909150957.12abe684@endymion>
References: <20190909150957.12abe684@endymion> <20190906130221.0b47a565@endymion> <20190906121510.GA17328@kroah.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     dhowells@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Thomas <trenn@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: /dev/mem and secure boot
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5357.1568626704.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 16 Sep 2019 10:38:24 +0100
Message-ID: <5358.1568626704@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 16 Sep 2019 09:38:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <jdelvare@suse.de> wrote:

> I wrongly assumed it had been merged upstream meanwhile but I was
> wrong. David, any reason why this didn't happen?

There were last-minute objections.

The patches got redesigned somewhat by Matthew Garrett and are now pending
pulling once again:

	https://lore.kernel.org/linux-security-module/alpine.LRH.2.21.1909101402230.20291@namei.org/T/#u

> Out of curiosity, are these patches in RHEL kernels?

Fedora, yes, my patchset; RHEL-7 and RHEL-8, no.

David
