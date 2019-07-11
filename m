Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964AAC742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 23:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5A8208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 23:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfGKXDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:03:32 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:55443 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727956AbfGKXDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 19:03:32 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud9.xs4all.net with ESMTPSA
        id li5whH1l5uEBxli61hD6fq; Fri, 12 Jul 2019 01:03:29 +0200
Message-ID: <2c4edfabf49998eb5da3a6adcabc006eb64bfe90.camel@tiscali.nl>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
From:   Paul Bolle <pebolle@tiscali.nl>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Souza, Jose" <jose.souza@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Jul 2019 01:03:20 +0200
In-Reply-To: <1562884722.15001.3.camel@HansenPartnership.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
         <1562875878.2840.0.camel@HansenPartnership.com>
         <27a5b2ca8cfc79bf617387a363ea7192acc4e1f0.camel@intel.com>
         <1562876880.2840.12.camel@HansenPartnership.com>
         <1562882235.13723.1.camel@HansenPartnership.com>
         <dad073fb4b06cf0abb7ab702a9474b9c443186eb.camel@intel.com>
         <1562884722.15001.3.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOOIjo/hjTpw8Kx9HPxKGF/XG3hTHQ2whjx5DOfVVX6gZ/ywNQWp10u4ovlzkiovBTq44u6HroosZSwCFuard1SMXtZhOMHzTTa8DClrW8TVfnmcEkq5
 JvXGh/CFjtshRRVV8gZakccH3jdzYkQ2llJTP5pexWsckFP53hGrxklegBhs2Ql1qaIhhlhc298/+F8zA0jJvXzzBh33q6Eo4xffJJ+GtRkpcJev6V4DWPhw
 iAjwx1i9mPFGKQoeL16F4alYRL/e4461zsUezONXAPcsxkoK3Ugj3kzG+q6RnxflkU/Asolabuelt8KDHlFl2YFZQJUATyt9YzIKljy/pfI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley schreef op do 11-07-2019 om 15:38 [-0700]:
> On Thu, 2019-07-11 at 22:26 +0000, Souza, Jose wrote:
> > It eventually comes back from screen freeze? Like moving the mouse or
> > typing brings it back?
> 
> No, it seems to be frozen for all time (at least until I got bored
> waiting, which was probably 20 minutes).  Even if I reboot the machine,
> the current screen state stays until the system powers off.

As I mentioned earlier, a suspend/resume cycle unfreezes the screen.

And I seem to remember that, if the gnome screen-locking eventually kicks in,
unlocking the screen still works, as the screen then isn't frozen anymore.

Thanks,


Paul Bolle

