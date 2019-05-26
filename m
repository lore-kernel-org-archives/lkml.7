Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB9DC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337C120815
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfEZTGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:06:41 -0400
Received: from mail02-md.ns.itscom.net ([175.177.155.112]:43454 "EHLO
        mail02-md.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfEZTGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:06:40 -0400
Received: from cmsa02-mds.s.noc.itscom.net (cmsa02-md.ns.itscom.net [175.177.0.92])
        by mail02-md-outgoing.ns.itscom.net (Postfix) with ESMTP id 4F32DB0068B;
        Mon, 27 May 2019 04:06:39 +0900 (JST)
Received: from jromail.nowhere ([219.110.50.76])
        by cmsa-md with ESMTP
        id UyTfhOMNFRqYFUyTfhth0V; Mon, 27 May 2019 04:06:39 +0900
Received: from jro by jrobl id 1hUyTe-0003tD-JL ; Mon, 27 May 2019 04:06:38 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH] concrete /proc/mounts
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kolyshkin@gmail.com
In-Reply-To: <20190526120719.GQ17978@ZenIV.linux.org.uk>
References: <17910.1558861894@jrobl> <20190526120719.GQ17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14953.1558897598.1@jrobl>
Date:   Mon, 27 May 2019 04:06:38 +0900
Message-ID: <14954.1558897598@jrobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro:
> Translation: let's generate the entire contents on the first read() and keep
> it until the sucker's closed; that way userland wont' see anything changing
> under it.  Oh, wait...
>
> NAK.

Do you mean that the change can hide other mountpoints which are
kept unchanged before/after read()?


J. R. Okajima
