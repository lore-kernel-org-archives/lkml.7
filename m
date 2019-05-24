Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B14C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41D72175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfEXXfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 19:35:44 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:49389 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfEXXfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 19:35:43 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hUJiw-0002yc-DP; Fri, 24 May 2019 17:35:42 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hUJiv-0006Bx-Uh; Fri, 24 May 2019 17:35:42 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     linux-kernel@vger.kernel.org
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
References: <20190523003916.20726-1-ebiederm@xmission.com>
Date:   Fri, 24 May 2019 18:35:31 -0500
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com> (Eric
        W. Biederman's message of "Wed, 22 May 2019 19:38:50 -0500")
Message-ID: <87imtzctoc.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hUJiv-0006Bx-Uh;;;mid=<87imtzctoc.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+B20jF1ziR89m3eWO13gGZa3HRiSPsR2M=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [REVIEW][PATCH 00/26] signal: Remove task argument from force_sig_info
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Oleg,

Any comments on this patchset?

Eric
