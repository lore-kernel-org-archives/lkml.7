Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD940C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8198020848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfCYVW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:22:26 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:53307 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729283AbfCYVW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:22:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 02C2218224D8E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 21:22:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sleet71_89715901d6e5a
X-Filterd-Recvd-Size: 1006
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 21:22:24 +0000 (UTC)
Message-ID: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Subject: MAINTAINERS: a scripted set of defective F: patterns and the
 commits that introduced them
From:   Joe Perches <joe@perches.com>
To:     LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Mar 2019 14:22:23 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Threaded onto this email are a few dozen defective F: patterns
and the commits that introduced the patterns and if found,
commits that either renamed or deleted the files that match the
pattern.

There's no good way to script a fix for these defective patterns
so I trust the appropriate maintainers will submit patches for
these defects.

