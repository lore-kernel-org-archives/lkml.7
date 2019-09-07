Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE41C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 15:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B0F2178F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 15:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436485AbfIGPoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 11:44:46 -0400
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:47553 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390962AbfIGPop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 11:44:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 965A018225DF5;
        Sat,  7 Sep 2019 15:44:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: legs34_c33b289dfa42
X-Filterd-Recvd-Size: 1227
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat,  7 Sep 2019 15:44:43 +0000 (UTC)
Message-ID: <25c248afff16f2b16b1c7ca4209e8ab727113f0d.camel@perches.com>
Subject: Re: [PATCH] Fixed parentheses malpractice in apex_driver.c
From:   Joe Perches <joe@perches.com>
To:     Sandro Volery <sandro@volery.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 07 Sep 2019 08:44:42 -0700
In-Reply-To: <534DB087-C4DC-49A7-93AA-6C7C437DA794@volery.com>
References: <534DB087-C4DC-49A7-93AA-6C7C437DA794@volery.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-09-07 at 17:34 +0200, Sandro Volery wrote:
> On patchwork I entered 'volery' as my username because I didn't know better, and now checkpatch always complains when I add 'signed-off-by' with my actual full name.

How does checkpatch complain?
There is no connection between patchwork
and checkpatch.

And do please set your email client to use shorter line lengths
or remember to add returns.

72 or so is typical.

