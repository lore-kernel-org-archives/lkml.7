Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A9AC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EA12133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfCRS4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:56:05 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:56488 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfCRS4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:56:05 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x2IItsF3003731;
        Mon, 18 Mar 2019 18:55:54 GMT
Date:   Mon, 18 Mar 2019 18:55:54 +0000
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Matthew Garrett <mjg59@google.com>
Cc:     jmorris@namei.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 09/27] hibernate: Disable when the kernel is locked down
Message-ID: <20190318185554.6265d387@alans-desktop>
In-Reply-To: <CACdnJuutrCYOoppScar53nfNnsrE6Oq36ayRGnJRLgh202aasw@mail.gmail.com>
References: <20190306235913.6631-1-matthewgarrett@google.com>
        <20190306235913.6631-10-matthewgarrett@google.com>
        <20190307145528.24c1b4d3@alans-desktop>
        <CACdnJuutrCYOoppScar53nfNnsrE6Oq36ayRGnJRLgh202aasw@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Suse have a solution for this that I'd like to see pushed again, but
> from a practical perspective enterprise distributions have been
> shipping this for some time without significant obvious customer
> complaint.

Probably because their IT department hasn't noticed 8)

Alan
