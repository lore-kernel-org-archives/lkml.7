Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF85C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE243216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfFZNsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:48:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48120 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfFZNse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:48:34 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hg8Hl-0002Ha-SM; Wed, 26 Jun 2019 15:48:30 +0200
Date:   Wed, 26 Jun 2019 15:48:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Juergen Gross <jgross@suse.com>
cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        peterz@infradead.org, srinivas.eeda@oracle.com,
        Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 4/7] Revert "xen: Introduce 'xen_nopv' to disable PV
 extensions for HVM guests."
In-Reply-To: <c77e5df3-77ac-bce2-ccd3-7848f1915b43@suse.com>
Message-ID: <alpine.DEB.2.21.1906261546460.32342@nanos.tec.linutronix.de>
References: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com> <1561377779-28036-5-git-send-email-zhenzhong.duan@oracle.com> <c77e5df3-77ac-bce2-ccd3-7848f1915b43@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019, Juergen Gross wrote:
> On 24.06.19 14:02, Zhenzhong Duan wrote:
> > This reverts commit 8d693b911bb9c57009c24cb1772d205b84c7985c.
> > 
> > Instead we use an unified parameter 'nopv' for all the hypervisor
> > platforms.
> > 
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: xen-devel@lists.xenproject.org
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

You're really sure that you want to break existing setups which might use
that already?

Command line parameters are ABI. You can map xen_nopv to the new shiny nopv
implementation but removing it?

Your decision, but you've been told :)

Thanks,

	tglx
