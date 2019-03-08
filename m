Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2A4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0AC20840
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfCHCo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:44:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfCHCo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:44:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC1F730832CB;
        Fri,  8 Mar 2019 02:44:57 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-140.pek2.redhat.com [10.72.12.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9559E19C66;
        Fri,  8 Mar 2019 02:44:54 +0000 (UTC)
Date:   Fri, 8 Mar 2019 10:44:50 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 2/3] scripts/ima: define a set of common functions
Message-ID: <20190308024450.GC7223@dhcp-128-65.nay.redhat.com>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
 <1548960936-7800-3-git-send-email-zohar@linux.ibm.com>
 <20190228134146.GA7528@dhcp-128-65.nay.redhat.com>
 <1551366343.10911.173.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551366343.10911.173.camel@linux.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 08 Mar 2019 02:44:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/19 at 10:05am, Mimi Zohar wrote:
> Hi Dave,
> 
> On Thu, 2019-02-28 at 21:41 +0800, Dave Young wrote:
> > Hi Mimi,
> >  
> > Sorry for jumping in late, just noticed this kexec selftests, I think we
> > also need a kexec load test not only for ima, but for general kexec
> 
> The IMA kselftest tests are for the coordination between the different
> methods of verifying file signatures.  In particular, for the kexec
> kernel image and kernel module signatures.
> 
> The initial IMA kselftest just verifies that in an environment
> requiring signed kexec kernel images, the kexec_load syscall fails. 
> 
> This week I posted additional IMA kselftests[1][2], including one for
> the kexec_file_load syscall.  I would really appreciate these
> kselftests being reviewed/acked.
> 
> Mimi
> 
> [1] Subject: [PATCH v2 0/5] selftests/ima: add kexec and kernel module tests
> [2] Patches available from the "next-queued-testing" branch
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/
> 

Hi Mimi,

Still did not get change to have a look at V2,  but seems you missed the
last chunk of comments about the secure boot mode in previous reply?

I just copy it hear:
'''
Do you want to get the Secureboot status here?
I got some advice from Peter Jones previously, thus we have below
in our kdump scripts:
https://src.fedoraproject.org/cgit/rpms/kexec-tools.git/tree/kdump-lib.sh

See the function is_secure_boot_enforced(), probably you can refer to
that function and check setup mode as well.
'''

Thanks
Dave
