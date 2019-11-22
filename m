Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F13C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EA22068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfKVRCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:02:06 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47150 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:02:06 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYCJm-0000wX-Rm; Fri, 22 Nov 2019 17:02:02 +0000
Date:   Fri, 22 Nov 2019 17:02:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de
Subject: Re: [PATCH v3 03/13] exfat: add inode operations
Message-ID: <20191122170202.GE26530@ZenIV.linux.org.uk>
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
 <CGME20191119094021epcas1p16e9ebb9fd8a1b25c64b09899a31988b9@epcas1p1.samsung.com>
 <20191119093718.3501-4-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119093718.3501-4-namjae.jeon@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 04:37:08AM -0500, Namjae Jeon wrote:
> This adds the implementation of inode operations for exfat.

Could you explain where is ->d_time ever read?
