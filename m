Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC190C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E61D20811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfC0Qxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:53:41 -0400
Received: from namei.org ([65.99.196.166]:58886 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfC0Qxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:53:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2RGrWKc031174;
        Wed, 27 Mar 2019 16:53:32 GMT
Date:   Thu, 28 Mar 2019 03:53:32 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V31 25/25] debugfs: Disable open() when kernel is locked
 down
In-Reply-To: <20190327053342.GA17484@kroah.com>
Message-ID: <alpine.LRH.2.21.1903280353120.31119@namei.org>
References: <20190326182742.16950-1-matthewgarrett@google.com> <20190326182742.16950-26-matthewgarrett@google.com> <CALCETrXDF2c2-gnOyNTnEn-uPAZp0AaSB_PB8e2y8jf7zo=Cyg@mail.gmail.com> <20190327003057.GA27311@kroah.com> <CALCETrVDDf4dj3Md1Nxc5P_NCToXGnAbEO3bGfwgKSfeVmU4Kw@mail.gmail.com>
 <20190327050615.GA548@kroah.com> <16124107-70D3-4CA0-9766-36FC6DC10128@amacapital.net> <20190327053342.GA17484@kroah.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019, Greg KH wrote:

> Personally, I think these are all just "confidentiality" type things,
> but who really knows given the wild-west nature of debugfs (which is as
> designed).  And given that I think this patch series just crazy anyway,
> I really don't care :)

Why do you think it's crazy?

-- 
James Morris
<jmorris@namei.org>

