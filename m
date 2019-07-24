Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3E7C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F75321734
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfGXUjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:39:45 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:47411 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727529AbfGXUjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:39:44 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud9.xs4all.net with ESMTPSA
        id qO30hK1x20QvJqO34hAGd1; Wed, 24 Jul 2019 22:39:42 +0200
Message-ID: <df4d83e5c5650ea2f1afde1469c9dc82d6120644.camel@tiscali.nl>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
From:   Paul Bolle <pebolle@tiscali.nl>
To:     "Souza, Jose" <jose.souza@intel.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Jul 2019 22:39:38 +0200
In-Reply-To: <d084df248afc1943e06c50d391a775d117064743.camel@intel.com>
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
         <b22cf290b089cb1174ec0fdeb15bdf2e90bf51dc.camel@tiscali.nl>
         <d084df248afc1943e06c50d391a775d117064743.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMGhzXSvgUU6XdTF2WME9sHm/ITasHYUkyDSQ+HTRlbfpg+ZiZbVxTBRJpE+6Ypg2M6EAsrdBFp9DJQ0oHEsqlJVUyaJqIkE61EIzYAQ6OgLTo8wl7na
 5+oq/sr5kEUpv4nwWTbxHVqHOovCOZQPfjUm8vEPeCdQUHo8VeesqX3dn528mxW2mhYG8m5Xq9xIG+GjAQFYmsl/EFlclZUuAFxhfd4JN9lhu0qYQeQRhWo2
 TFOKIiTNMC36vJSO91CJlwlggoi7Bwp56MgCtEgOW3RkJI6TTLQGdt3ocloYjEy4qJ7qJEiE722E2lE3cfxFZGQfe1TmwGVTPtEnWx4QWRk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jose,

Souza, Jose schreef op wo 24-07-2019 om 20:27 [+0000]:
> We fixed the patch instead of revert it, it is merged on drm-tip and on
> his way to linux-stable.

That should be (drm-tip) commit b5ea9c933700 ("drm/i915/vbt: Fix VBT parsing
for the PSR section"). Correct?

> Huge thanks again

You're welcome.


Paul Bolle

