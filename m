Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB5ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E4321928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfIKJNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:13:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:60866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726702AbfIKJNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:13:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1FCDFB033;
        Wed, 11 Sep 2019 09:13:41 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen/pci: try to reserve MCFG areas earlier
To:     Igor Druzhinin <igor.druzhinin@citrix.com>
Cc:     xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>
References: <1567556431-9809-1-git-send-email-igor.druzhinin@citrix.com>
 <5054ad91-5b87-652c-873a-b31758948bd7@oracle.com>
 <e3114d56-51cd-b973-1ada-f6a60a7e99cc@citrix.com>
 <43b7da04-5c42-80d8-898b-470ee1c91ed2@oracle.com>
 <adefac87-c2b3-b67f-fb4d-d763ce920bef@citrix.com>
 <1695c88d-e5ad-1854-cdef-3cd95c812574@oracle.com>
 <4d3bf854-51de-99e4-9a40-a64c581bdd10@citrix.com>
 <bc3da154-d451-02cf-6154-5e0dc721a6e6@oracle.com>
 <c45b8786-5735-a95d-bc40-61372c326037@citrix.com>
 <43e492ff-f967-7218-65c4-d16581fabea3@oracle.com>
 <416ff4b7-3186-f61a-75fa-bcfc968f8117@citrix.com>
 <df64cd80-d92e-27ad-b1bc-e58184379e50@oracle.com>
 <d281baaf-a6d7-306e-63aa-b84552ac3ea5@citrix.com>
 <9ac1f34b-ea2a-3818-4cbd-a22a9a475dd4@oracle.com>
 <74c9d2cc-a528-2cec-099e-0d803aeace6f@citrix.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <65b8d74a-2f7b-a257-a750-9dada5206f01@suse.com>
Date:   Wed, 11 Sep 2019 11:13:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <74c9d2cc-a528-2cec-099e-0d803aeace6f@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.2019 03:15, Igor Druzhinin wrote:
> Another thing that I implied by "not supporting" but want to explicitly
> call out is that currently Xen will refuse reserving any MCFG area
> unless it actually existed in MCFG table at boot. I don't clearly
> understand reasoning behind it but it might be worth relaxing at least
> size matching restriction on Xen side now with this change.

I guess it's because no-one had a system were it would be needed,
and hence could be tested.

Jan
