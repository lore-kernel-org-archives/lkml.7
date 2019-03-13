Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC797C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3E820651
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfCMPaR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:30:17 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:44490 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfCMPaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:30:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DF0F96091877;
        Wed, 13 Mar 2019 16:30:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8kml4iUHCbwV; Wed, 13 Mar 2019 16:30:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 87935609187F;
        Wed, 13 Mar 2019 16:30:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 60h5QYQyybex; Wed, 13 Mar 2019 16:30:08 +0100 (CET)
Received: from blindfold.localnet (089144193070.atnat0002.highway.a1.net [89.144.193.70])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 84ABD6091877;
        Wed, 13 Mar 2019 16:30:05 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>, david@sigma-star.at
Subject: Re: overlayfs vs. fscrypt
Date:   Wed, 13 Mar 2019 16:30:03 +0100
Message-ID: <3369831.hnip8tpcNh@blindfold>
In-Reply-To: <20190313151633.GA672@mit.edu>
References: <4603533.ZIfxmiEf7K@blindfold> <CAOQ4uxhqQKzriL0An4Tvzc1E_LffL-z9q1otOW_RdD1ZdKWP3Q@mail.gmail.com> <20190313151633.GA672@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 13. März 2019, 16:16:33 CET schrieb Theodore Ts'o:
> So before we talk about how to make things work from a technical
> perspective, we should consider what the use case happens to be, and
> what are the security requirements.  *Why* are we trying to use the
> combination of overlayfs and fscrypt, and what are the security
> properties we are trying to provide to someone who is relying on this
> combination?

Well, as stated, on (deeply) embedded systems overlayfs is common.
You have a lowerdir with read-only files and an read-write upper dir.
Of course both lower and upper directory need to be encrypted.
In my case ubifs+fscrypt, sometimes also combined with an encrypted+authenticated
squashfs.

Thanks,
//richard


