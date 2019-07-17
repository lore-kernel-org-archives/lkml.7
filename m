Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFB6C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3D5217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfGQV1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:27:45 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:47367 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727410AbfGQV1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:27:45 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id nrSTh8SpSHOZUnrSWhrTru; Wed, 17 Jul 2019 23:27:42 +0200
Message-ID: <9ef8fc1ae2c3a9bad588899488a781333af4449a.camel@tiscali.nl>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
From:   Paul Bolle <pebolle@tiscali.nl>
To:     "Souza, Jose" <jose.souza@intel.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Jul 2019 23:27:29 +0200
In-Reply-To: <a10f009fc160f05077760ff59cd86a9c99006b39.camel@intel.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfATkZ51l4cPn6KwISX15HJEDQXz/Y3hweNe4NEoGjmuNvl9Zlvy+FlZbJskaGRI3PjtVQ6yNOdRXxvzTCM+A4kKw6wLMH9sB4E8PFUsEXyqPGh+SF16B
 AWlntmLHqr5lTIY7qwqFwNnQc7FceGEvARg19cgDyobucmEGZUpVw53EEPzamOnrW4v2Wf2lmVLGN0BtpsB11Usj0oPR8W3TRrbpN/cVE9kbALeRUEvSsOPh
 mQ3NkqJcZspa9TS5QvDVGuBl1l+YdkiNVwiin58++zcUR1v3PeWIYptW/IIbI5QnUNjzR8F3EeMnc0hdtUikgpRWqInrWbFznh+iaxatwPc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jose,

Souza, Jose schreef op di 16-07-2019 om 16:32 [+0000]:
> Paul and James could you test this final solution(at least for 5.2)?
> Please revert the hack patch and apply this one.

I've just reached a day of uptime with your revert. (The proper uptime is just
a fraction of a day, this being a laptop.) Anyhow, no screen freezes occurred
during this day.

So feel free to add my Tested-by tag to your revert. But please don't forget
that James earned a Reported-by tag.

Thanks,


Paul Bolle

