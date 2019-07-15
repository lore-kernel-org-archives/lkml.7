Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7315C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9182145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbfGOVfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:35:11 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:59365 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730156AbfGOVfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:35:11 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud9.xs4all.net with ESMTPSA
        id n8cdhhG1kuEBxn8cghMp2U; Mon, 15 Jul 2019 23:35:08 +0200
Message-ID: <595d9bc87bf47717c8675eb5b1a1cbb2bc463752.camel@tiscali.nl>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
From:   Paul Bolle <pebolle@tiscali.nl>
To:     "Souza, Jose" <jose.souza@intel.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 15 Jul 2019 23:34:59 +0200
In-Reply-To: <143142cad4a946361a0bf285b6f1701c81096c7b.camel@intel.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH6I1vuIhhM+oakc5dwVYTm3I/Gg+CbbYwfjkax0Kna5ekLjxFrG0nbLTCBLvqmk8OQI6i15Dn5y6XOuuoxMcJfqnCXICRSmfCGLQCnrwR30VbKzZ9QB
 8N+lHPKORktdnAsANPfx3qsJaWItk9IeAy84ugJfL9Ix6b3GkjpMP9t/CyXX0AG4Q/0jW3IDnlvuSDkriIL1BSH5D5spyWCs11Af+F/OivP58lMk9sb3X3EV
 1IkvWL3f+6zsekrQPCs0F62nnDImRNPD0dXm2aevHZ1ZZ8RyWfxJW0ePkO48QaNQw0LVYrybuYah4R4KeKio2KNKWUc+vqNro254SK3fS+4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jose,

Souza, Jose schreef op ma 15-07-2019 om 21:03 [+0000]:
> So the issue did not happened again with the patch applied?

Not in the three days that I've been running 5.2 kernels with the hack applied
(so that should be about twelve hours of proper uptime).

> If you still have the kernel 5.1 installed could you share your
> /sys/kernel/debug/dri/0/i915_edp_psr_status with the older kernel?
> We want to check if training values changed between kernel versions.

Sure. On 5.1.17 I get:
    Sink support: yes [0x01]
    PSR mode: PSR1 enabled
    Source PSR ctl: enabled [0x81f00626]
    Source PSR status: IDLE [0x040b0001]
    Busy frontbuffer bits: 0x00000000

And, in case you need it, on 5.2.1+hack I get:
    Sink support: yes [0x01]
    PSR mode: PSR1 enabled
    Source PSR ctl: enabled [0x81f00626]
    Source PSR status: IDLE [0x04030006]
    Busy frontbuffer bits: 0x00000000

Hope this helps,


Paul

