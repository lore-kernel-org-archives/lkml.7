Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE2AC31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 23:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175D22084B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 23:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563059715;
	bh=65rpYORBj3P4JOejtpandAB6/rp4F11vqJUSLELNJx4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RGClRFtvUXybg1CfnT2NTYptxrcZslJZua+1JiefCePNn+e+hSdphZfxSvcU+mEG9
	 ft7WG7+X16U8n9OcjZIMTRD+9nJKw+QPtXdHC8u6lbkTQmYRTy610WhKpndFPiJg4z
	 2ZY4hbT6pE43AAxqBode7ryUIG5qCqb9rrJitJXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfGMXPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 19:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728733AbfGMXPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 19:15:13 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-1 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563059713;
        bh=65rpYORBj3P4JOejtpandAB6/rp4F11vqJUSLELNJx4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0zPnKG/gw0szU68vN+2WHYGo+H5a8JVm3LUxpvQP0JGllDjnHOxuf3dHlVWvfHT3T
         nF8SK9PClYJsS4pIADbipVPDclh6pttJubWwOBbKXobKPlourBnetBIcCF6ZyPM+TN
         0o/AbZBO6jr6/mnmu0u0DASTAg90OGS12W/VECgY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ims6eey7.fsf@concordia.ellerman.id.au>
References: <87ims6eey7.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ims6eey7.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.3-1
X-PR-Tracked-Commit-Id: f5a9e488d62360c91c5770bd55a0b40e419a71ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 192f0f8e9db7efe4ac98d47f5fa4334e43c1204d
Message-Id: <156305971325.4281.6567702737588394599.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 23:15:13 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, aik@ozlabs.ru,
        ajd@linux.ibm.com, alastair@d-silva.org,
        andrew.donnellan@au1.ibm.com, aneesh.kumar@linux.ibm.com,
        anju@linux.vnet.ibm.com, anton@ozlabs.org,
        atrajeev@linux.vnet.ibm.com, blackgod016574@gmail.com, cai@lca.pw,
        christophe.leroy@c-s.fr, chunkeey@gmail.com, dja@axtens.net,
        efremov@linux.com, fbarrat@linux.ibm.com, geert+renesas@glider.be,
        geliangtang@gmail.com, gregkh@linuxfoundation.org,
        gromero@linux.vnet.ibm.com, groug@kaod.org, hch@lst.de,
        info@metux.net, krzk@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, malat@debian.org, mikey@neuling.org,
        nathanl@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        nishadkamdar@gmail.com, npiggin@gmail.com, oohall@gmail.com,
        ravi.bangoria@linux.ibm.com, rostedt@goodmis.org,
        ruscur@russell.cc, sathnaga@linux.vnet.ibm.com,
        schwab@linux-m68k.org, sjitindarsingh@gmail.com,
        stewart@linux.ibm.com, yamada.masahiro@socionext.com,
        yuehaibing@huawei.com, zhangshaokun@hisilicon.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Jul 2019 14:28:00 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/192f0f8e9db7efe4ac98d47f5fa4334e43c1204d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
