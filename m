Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3158AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCFC22ADC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbfGXTXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:23:43 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:36527 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728592AbfGXTXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:23:38 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud9.xs4all.net with ESMTPSA
        id qMrLhJkQP0QvJqMrOhAAlA; Wed, 24 Jul 2019 21:23:36 +0200
Message-ID: <b22cf290b089cb1174ec0fdeb15bdf2e90bf51dc.camel@tiscali.nl>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
From:   Paul Bolle <pebolle@tiscali.nl>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Souza, Jose" <jose.souza@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Jul 2019 21:23:31 +0200
In-Reply-To: <1563398966.3438.5.camel@HansenPartnership.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
         <1562875878.2840.0.camel@HansenPartnership.com>
         <27a5b2ca8cfc79bf617387a363ea7192acc4e1f0.camel@intel.com>
         <1562876880.2840.12.camel@HansenPartnership.com>
         <1562882235.13723.1.camel@HansenPartnership.com>
         <dad073fb4b06cf0abb7ab702a9474b9c443186eb.camel@intel.com>
         <1562884722.15001.3.camel@HansenPartnership.com>
         <2c4edfabf49998eb5da3a6adcabc006eb64bfe90.camel@tiscali.nl>
         <55f4d1c242d684ca2742e8c14613d810a9ee9504.camel@intel.com>
         <1562888433.2915.0.camel@HansenPartnership.com>
         <1562941185.3398.1.camel@HansenPartnership.com>
         <68472c5f390731e170221809a12d88cb3bc6460e.camel@tiscali.nl>
         <143142cad4a946361a0bf285b6f1701c81096c7b.camel@intel.com>
         <595d9bc87bf47717c8675eb5b1a1cbb2bc463752.camel@tiscali.nl>
         <a10f009fc160f05077760ff59cd86a9c99006b39.camel@intel.com>
         <9ef8fc1ae2c3a9bad588899488a781333af4449a.camel@tiscali.nl>
         <1563398966.3438.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAak953jrG8+iI+u62M70niCTw5ChlP5YsW2e6m8dc3mQ9x0fFKajOQht3QdhLJaClnveoYliKavy1/mjNjvYgjLgJkltxUqoKdO+uN4o/rhdgecDc7K
 1lqJTGziXjpIMvuFwlp0VMWNObq5EFKq2jIdr/OvXshg1kMKZAr9H1a7DBcYPx82ZFu4aewwAqVuLxjcZYrDEHDtHwdvOGcxYjP4ntjZ9ieER4eb6PG+tOlA
 YizXsZtaPUnV2QnqvzpyfyFRUHisoqIJpl3bWW4G+tfFqK9uTrAv6EnCCpodZMGU+CvMlmMpMjmfW8FMwWMIDWW0RMaZlmmE2b5KQJ8oQoc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jose,

James Bottomley schreef op do 18-07-2019 om 06:29 [+0900]:
> On Wed, 2019-07-17 at 23:27 +0200, Paul Bolle wrote:
> > I've just reached a day of uptime with your revert. (The proper
> > uptime is just a fraction of a day, this being a laptop.) Anyhow, no
> > screen freezes occurred during this day.
> 
> I'm afraid my status is that I'm in Tokyo doing conference
> presentations (and kernel demos) so I'm a bit reluctant to mess with my
> setup until I finish everything on Friday, but I will test it after
> then, promise.

By now I'm testing this for a week (currently on top of 5.2.2). Still no
freezes whatsoever. 

So what's the status of this revert? Unless this is something pretty obscure
that for some odd reason only James and I are able to hit it would be nice to
get this into stable before the main distros switch over to 5.2.y.

Thanks,


Paul Bolle

