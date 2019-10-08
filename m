Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E630C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F20D20867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfJHHbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:31:46 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:32808 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729740AbfJHHbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:31:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 409DA180A68B8;
        Tue,  8 Oct 2019 07:31:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bait88_839f77442f42d
X-Filterd-Recvd-Size: 978
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Oct 2019 07:31:44 +0000 (UTC)
Message-ID: <aadb19c32e7d6b2560d257b459920da9e935c5e8.camel@perches.com>
Subject: Re: checkpatch error
From:   Joe Perches <joe@perches.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     apw@canonical.com
Date:   Tue, 08 Oct 2019 00:31:43 -0700
In-Reply-To: <02cc0e89-8b48-14f6-aabe-ec1201df59aa@oracle.com>
References: <02cc0e89-8b48-14f6-aabe-ec1201df59aa@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 12:02 +0800, Zhenzhong Duan wrote:
> Hi,
> 
> When I run checkpatch.pl with a patch doing reverting operation, it 
> reports a false positive error, Should I ignore the error or it's a bug?

Ignore it.


