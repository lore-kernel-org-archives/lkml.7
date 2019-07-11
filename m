Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C12C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D525E206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UGq3qb27";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="sLIy0+6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfGKU2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:28:03 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40404 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728405AbfGKU2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:28:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EFEBE8EE2F6;
        Thu, 11 Jul 2019 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562876883;
        bh=tOhs8f4r8n99C7Dwe6jIkqXz79BuqGcsiAAftv+McgI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UGq3qb27timwDHMLk7ncnVTghcfVqRM8uIJ2c3VXsxVzeBnSpJ05ifmuo/cKiE913
         +FpMQJzIMwvxxIKr2j5htkqCBzF8LsYIgWLHgXLdRiqGII9tN1IesHtbBNO/psVeD0
         8o+vVV/83poj8tSSKzyMEi9Mzf1C0ID+G9nLhe/w=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R5EAXpAep5mT; Thu, 11 Jul 2019 13:28:02 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 82E568EE0C7;
        Thu, 11 Jul 2019 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562876882;
        bh=tOhs8f4r8n99C7Dwe6jIkqXz79BuqGcsiAAftv+McgI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sLIy0+6biRRec3aXnsHVZ67zVQyhZ9bymjkyNrSLJ003OZn6lNI8Xc8QPOnE4Tyb9
         KSJt2Whj6igTcZacZIk6ByzN3UrGEexy0n8GPUg/qfRLZ+t8tHk36bBSTHt4Fw/G1+
         ScL5oS9mz5yI1BYyRFDJPiFfYq9Dk9n+HKekW3z0=
Message-ID: <1562876880.2840.12.camel@HansenPartnership.com>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Souza, Jose" <jose.souza@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 11 Jul 2019 13:28:00 -0700
In-Reply-To: <27a5b2ca8cfc79bf617387a363ea7192acc4e1f0.camel@intel.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
         <1562875878.2840.0.camel@HansenPartnership.com>
         <27a5b2ca8cfc79bf617387a363ea7192acc4e1f0.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-11 at 20:25 +0000, Souza, Jose wrote:
> On Thu, 2019-07-11 at 13:11 -0700, James Bottomley wrote:
> > On Thu, 2019-07-11 at 10:29 +0100, Chris Wilson wrote:
> > > Quoting James Bottomley (2019-06-29 19:56:52)
> > > > The symptoms are really weird: the screen image is locked in
> > > > place.  The machine is still functional and if I log in over
> > > > the network can do anything I like, including killing the X
> > > > server and the display will never alter.  It also seems that
> > > > the system is accepting keyboard input because when it freezes
> > > > I can cat information to a file (if the mouse was over an
> > > > xterm) and verify over the network the file contents. Nothing
> > > > unusual appears in dmesg when the lockup happens.
> > > > 
> > > > The last kernel I booted successfully on the system was 5.0, so
> > > > I'll try compiling 5.1 to narrow down the changes.
> > > 
> > > It's likely this is panel self-refresh going haywire.
> > > 
> > > commit 8f6e87d6d561f10cfa48a687345512419839b6d8
> > > Author: José Roberto de Souza <jose.souza@intel.com>
> > > Date:   Thu Mar 7 16:00:50 2019 -0800
> > > 
> > >     drm/i915: Enable PSR2 by default
> > > 
> > >     The support for PSR2 was polished, IGT tests for PSR2 was
> > > added and
> > >     it was tested performing regular user workloads like
> > > browsing,
> > >     editing documents and compiling Linux, so it is time to
> > > enable it by
> > >     default and enjoy even more power-savings.
> > > 
> > > Temporary workaround would be to set i915.enable_psr=0
> > 
> > It looks plausible.  I have to say I was just about to mark a
> > bisect containing this as good, but that probably reflects my
> > difficulty
> > reproducing the issue.
> 
> Take at look of what PSR version is supported by your panel, it
> likely that a notebook shipped with Skylake will have panel that
> supports only PSR1 so that patch has no effect on your machine.
> 
> sudo more /sys/kernel/debug/dri/0/i915_edp_psr_status
> Sink support: yes [0x01]

It says

Sink support: yes [0x01]
PSR mode: PSR1 enabled
Source PSR ctl: enabled [0x81f00726]
Source PSR status: IDLE [0x04010212]
Busy frontbuffer bits: 0x00000000


I've also updated to the released 5.2 kernel and am running with the
debug parameters you requested ... but so far no reproduction.

James

